import { Article, ArticleContent } from '../bean/Article';

@Preview
@CustomDialog
struct MyCustomDialog {
  //  自定义弹窗必须声明controller
  controller: CustomDialogController
  addImage: () => void
  addText: () => void
  @ObjectLink article: Article

  build() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      Button("添加图片")
        .onClick(() => {
          //          this.addImage()
          let new_item
          if (this.article.content.length > 0) {
            //新增一个临时变量存储新的ArticleContent对象
            new_item = new ArticleContent({
              contentIndex: this.article.content[this.article.content.length-1].contentIndex + 1,
              contentType: "image",
              contentText: null,
              contentImage: $r('app.media.ic_launcher')
            })
          } else {
            //新增一个临时变量存储新的ArticleContent对象
            new_item = new ArticleContent({
              contentIndex: 0,
              contentType: "image",
              contentText: null,
              contentImage: $r('app.media.ic_launcher')
            })
          }
          let new_arr = JSON.parse(JSON.stringify(this.article.content))
          new_arr.push(new_item)
          this.article.content = new_arr
          this.controller.close()
        })
      Button("添加文字")
        .margin({ left: 10 })
        .onClick(() => {
          //          this.addText()
          let new_item
          if (this.article.content.length > 0) {
            new_item = new ArticleContent({
              contentIndex: this.article.content[this.article.content.length-1].contentIndex + 1,
              contentType: "text",
              contentText: "这是新增的内容这是新增的内容这是新增的内容这是新增的内容这是新增的内容这是新增的内容",
              contentImage: null
            })
          } else {
            new_item = new ArticleContent({
              contentIndex: 0,
              contentType: "text",
              contentText: "这是新增的内容这是新增的内容这是新增的内容这是新增的内容这是新增的内容这是新增的内容",
              contentImage: null
            })
          }

          let new_arr = JSON.parse(JSON.stringify(this.article.content))
          new_arr.push(new_item)
          this.article.content = new_arr
          this.controller.close()
        })
    }
    .margin(10)
    .width("100%")
    .height(200)
  }
}

export default MyCustomDialog

