import MyCustomDialog from "../common/components/myCustomDialog"
import { Article, ArticleContent } from "../common/bean/Article"
import ArticleContentUi from "../common/components/ArticleContent/ArticleContentUi"
import dataStorage from '@ohos.data.storage';
import featureAbility from '@ohos.ability.featureAbility'; // 用于获取文件存储路径

@Entry
@Component
struct ArticlePage {
  @State userClick: number = -1
  @Provide("article") article: Article = new Article({
    title: "这是第一篇文章标题",
    content: [
      new ArticleContent({
        contentIndex: 0,
        contentType: "text",
        contentText: "这是第一部分内容这是第一部分内容这是第一部分内容这是第一部分内容这是第一部分内容这是第一部分内容这是第一部分内容",
        contentImage: null
      }),
      new ArticleContent({
        contentIndex: 1,
        contentType: "image",
        contentText: null,
        contentImage: $r('app.media.icon')
      }),
      new ArticleContent({
        contentIndex: 2,
        contentType: "text",
        contentText: "这是第二部分内容这是第二部分内容这是第二部分内容这是第二部分内容这是第二部分内容这是第二部分内容这是第二部分内容",
        contentImage: null
      }),
      new ArticleContent({
        contentIndex: 3,
        contentType: "image",
        contentText: null,
        contentImage: $r('app.media.icon')
      })
    ]
  })

  //使用自定义类型的方式，对Panel控件的一些属性进行定义，方便进行复用
  @Provide("panelInput") panelInput: {
    panelType: string // titleText`或 contentText
    panelText: string //文本本身
    panelIsShow: boolean //判断是否显示panel组件
  } = { panelType: "titleText", panelText: this.article.title, panelIsShow: false }

  onPageShow() {
    this.initKvStorage()
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      addImage: this.addImage,
      addText: this.addText,
      article: this.article
    }),
    alignment: DialogAlignment.Bottom
  })

  getContext() {
    var context = null
    if (context == null) {
      context = featureAbility.getContext()
    }
    return context
  }

  //初始化轻量数据库
  initKvStorage() {
    //    let context = this.getContext()
    //    context.getFilesDir().then((filePath) => {
    //      console.info("======================>getFilesDirPromsie====================>");
    //      console.info("filePath=" + filePath)
    //      let promise = dataStorage.getStorage(filePath + '/mystore');
    //
    //      promise.then((storage) => {
    //        let getPromise = storage.put('TextTitle', '第一次添加到数据库的文本'); // 保存数据到缓存的storage实例中
    //        getPromise.then(() => {
    //          console.info("Succeeded in putting the value of startup.");
    //        }).catch((err) => {
    //          console.info("Failed to put the value of startup with err: " + err);
    //        })
    //      }).catch((err) => {
    //        console.info("Failed to get the storage.");
    //      })
    //    });
  }

  getKvStorage() {
    //    let context = this.getContext()
    //    context.getFilesDir().then((filePath) => {
    //      console.info("======================>getFilesDirPromsie====================>");
    //      console.info("filePath=" + filePath)
    //      let promise = dataStorage.getStorage(filePath + '/mystore');
    //
    //      promise.then((storage) => {
    //        let getPromise = storage.get('TextTitle', '默认内容'); // 保存数据到缓存的storage实例中
    //        getPromise.then((value) => {
    //          console.info("Succeeded in putting the value of startup.");
    //          this.article.title = value.toString()
    //        }).catch((err) => {
    //          console.info("Failed to put the value of startup with err: " + err);
    //        })
    //      }).catch((err) => {
    //        console.info("Failed to get the storage.");
    //      })
    //    });
  }

  addImage() {
    console.info("增加图片")
  }

  addText() {
    console.info("增加文字")
  }

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {
      Scroll() {
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Start,
          alignItems: ItemAlign.Center
        }) {
          Row() {
            Text(this.article.title)
              .fontSize(20)
              .padding(5)
              .onClick(() => {
                this.panelInput.panelIsShow = true
                this.panelInput.panelText = this.article.title
              })
          }
          .width("100%")

          Button("保存")
            .width(80)
            .height(40)
            .position({ x: "100%", y: 0 })
            .markAnchor({ x: 80, y: 0 })
            .onClick(() => {
              this.getKvStorage()
            })
          Divider()
            .strokeWidth(1)
            .margin({ top: 5, bottom: 5 })
          //内容列表
          ArticleContentUi({ userClick: $userClick })

          Button("添加组件")
            .width(160)
            .height(40)
            .margin({ top: 5 })
            .onClick(() => {
              this.dialogController.open()
            })
        }
        .padding(10)
      }
      //抽屉组件
      Panel(this.panelInput.panelIsShow) {
        //      Panel(true) {
        Column() {
          TextArea({ text: this.panelInput.panelText })
            .width("100%")
            .height(120)
            .onChange((value) => {
              //将实时输入的内容保存到panelInput的panelText字段中，保存时统一进行操作
              this.panelInput.panelText = value
            })
          Row() {
            Button("关闭")
              .margin({ top: 10 })
              .onClick(() => {
                this.panelInput.panelIsShow = false
                this.panelInput.panelText = ""
              })
            Blank()
            Button("保存")
              .margin({ top: 10 })
              .onClick(() => {
                if (this.panelInput.panelType == "titleText") {
                  //当前修改的是标题内容
                  this.article.title = this.panelInput.panelText
                } else {
                  //当前修改的是列表中的文字内容，需要获取到具体点击的哪一个item的索引
                  let contentList = JSON.parse(JSON.stringify(this.article.content))
                  contentList.forEach((item) => {
                    if (item.contentIndex == this.userClick) {
                      item.contentText = this.panelInput.panelText
                    }
                  })
                  this.article.content = contentList
                }
                this.panelInput.panelIsShow = false
                this.panelInput.panelText = ""
              })
          }
          .width("100%")
        }
        .padding(20)
      }
      .type(PanelType.Foldable)
      .mode(PanelMode.Half)
      .dragBar(true) // 默认开启
      .halfHeight(300) // 默认一半
      .onChange((width: number, height: number, mode: PanelMode) => {
        console.info(`width:${width},height:${height},mode:${mode}`)
      })
    }.width("100%").height("100%")
  }
}