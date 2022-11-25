import { Article } from '../../bean/Article';
import featureAbility from '@ohos.ability.featureAbility'
import wantConstant from '@ohos.ability.wantConstant'

@Component
struct ContentItemUi {
  //  @Consume("article") article: Article
  @ObjectLink article: Article
  @Prop contentIndex: number
  @Prop contentType: string
  @Prop contentText: string
  contentImage: Resource
  @Link userClick: number
  @Consume("panelInput") panelInput: {
    panelType: string // titleText`或 contentText
    panelText: string //文本本身
    panelIsShow: boolean //判断是否显示panel组件
  }

  //删除操作
  deleteItem() {
    //此操作通过直接操作article对象的形式触发页面重新渲染
    let new_arr = JSON.parse(JSON.stringify(this.article.content)) //深拷贝改变数据源指针，如此才可引发页面重新渲染
    new_arr.forEach((item, index) => {
      //当遍历到的是当前点击出现删除的数据，再进行操作
      if (item.contentIndex == this.userClick) {
        new_arr.splice(index, 1)
      }
    })
    this.article.content = new_arr
  }

  build() {
    Column() {
      if (this.contentType == "text") {
        Text(this.contentText)
          .fontSize(15)
          .width("100%")
          .margin({ top: 5 })
          .onClick(() => {
            this.userClick = this.contentIndex
          })
        if (this.userClick == this.contentIndex) {
          Text(this.contentText)
            .fontSize(15)
            .width("100%")
            .margin({ top: 5 })
            .backgroundColor("#bedddddd")
            .position({ x: 0, y: 0 })
          Button("编辑")
            .width(65)
            .height(30)
            .type(ButtonType.Normal)
            .backgroundColor("#ffffd86c")
            .position({ x: 0, y: 0 })
            .onClick(() => {
              this.panelInput.panelType = "contentText"
              this.panelInput.panelText = this.contentText
              this.panelInput.panelIsShow = true
            })
          Button("删除")
            .width(65)
            .height(30)
            .type(ButtonType.Normal)
            .backgroundColor("#ffff5252")
            .position({ x: 65, y: 0 })
            .onClick(() => {
              this.deleteItem()
            })
        }
      }
      else if (this.contentType == "image") {
        Image(this.contentImage)
          .width("100%")
          .height(360 / 16 * 9)
          .margin({ top: 5 })
          .borderRadius(15)
          .onClick(() => {
            this.userClick = this.contentIndex
          })
        if (this.userClick == this.contentIndex) {
          Image(this.contentImage)
            .width("100%")
            .height(360 / 16 * 9)
            .margin({ top: 5 })
            .borderRadius(15)
            .blur(35)
            .position({ x: 0, y: 0 })
          Button("编辑")
            .width(65)
            .height(30)
            .type(ButtonType.Normal)
            .backgroundColor("#ffffd86c")
            .position({ x: 0, y: 0 })
            .onClick(() => {
              featureAbility.startAbilityForResult(
                {
                  want:
                  {
                    action: "ohos.hidisk.intent.action.choose"
                  },
                },
                (err, data) => {
                  console.info("err: " + JSON.stringify(err) + "data: " + JSON.stringify(data))
                  if (data.want) {
                    let imageUrl = data.want.parameters["select-item-list"][0].decodedPath
                    let new_arr = JSON.parse(JSON.stringify(this.article.content))
                    new_arr.forEach((item) => {
                      if (item.contentIndex == this.userClick) {
                        console.info("imageUrl=" + imageUrl)
                        item.contentImage = "dataability://" + imageUrl
                      }
                    })
                    this.article.content = new_arr
                  }
                }
              );
            })
          Button("删除")
            .width(65)
            .height(30)
            .type(ButtonType.Normal)
            .backgroundColor("#ffff5252")
            .position({ x: 65, y: 0 })
            .onClick(() => {
              this.deleteItem()
            })
        }
      }
    }
  }
}

export default ContentItemUi