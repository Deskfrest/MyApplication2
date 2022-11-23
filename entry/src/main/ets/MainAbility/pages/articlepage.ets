import MyCustomDialog from "../common/components/myCustomDialog"

@Entry
@Component
struct ArticlePage {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      addImage: this.addImage,
      addText: this.addText
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
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      Row(){
        Text("请输入文章标题")
          .fontSize(30)
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
      Text("文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容文章内容")
        .fontSize(15)
        .margin({ top: 5 })
      Image($r('app.media.icon'))
        .width("100%")
        .height(360 / 16 * 9)
        .margin({ top: 5 })
        .borderRadius(15)
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
}