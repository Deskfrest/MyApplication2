import MyCustomDialog from "../common/components/myCustomDialog"
import { Article, ArticleContent } from "../common/bean/Article"
import ArticleContentUi from "../common/components/ArticleContent/ArticleContentUi"

@Entry
@Component
struct ArticlePage {


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

  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      addImage: this.addImage,
      addText: this.addText,
      article: this.article
    }),
    alignment: DialogAlignment.Bottom
  })

  addImage() {
    console.info("增加图片")
  }

  addText() {
    console.info("增加文字")
  }

  build() {
    Stack({
      alignContent:Alignment.Top
    }){
      Scroll(){
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Start,
          alignItems: ItemAlign.Center
        }) {
          Row() {
            Text(this.article.title)
              .fontSize(20)
              .padding(5)
          }
          .width("100%")

          Button("保存")
            .width(80)
            .height(40)
            .position({ x: "100%", y: 0 })
            .markAnchor({ x: 80, y: 0 })
          Divider()
            .strokeWidth(1)
            .margin({ top: 5, bottom: 5 })
          //内容列表
          ArticleContentUi()

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
      Panel(true) {
        Column() {
          TextArea()
            .width("100%")
            .height(120)
          Button("关闭")
            .margin({top:10})
        }
        .padding(20)
      }
      .type(PanelType.Foldable).mode(PanelMode.Half)
      .dragBar(true) // 默认开启
      .halfHeight(300) // 默认一半
      .onChange((width: number, height: number, mode: PanelMode) => {
        console.info(`width:${width},height:${height},mode:${mode}`)
      })

    }.width("100%").height("100%")
  }
}