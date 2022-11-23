@Preview
@CustomDialog
struct MyCustomDialog {
  //  自定义弹窗必须声明controller
  controller: CustomDialogController
  addImage: () => void
  addText: () => void

  build() {
    Flex({
      justifyContent: FlexAlign.Center,
      alignItems:ItemAlign.Center
    }) {
      Button("添加图片")
        .onClick(() => {
          this.addImage()
          this.controller.close()
        })
      Button("添加文字")
        .margin({ left: 10 })
        .onClick(() => {
          this.addText()
          this.controller.close()
        })
    }
    .margin(10)
    .width("100%")
    .height(200)
  }
}

export default MyCustomDialog

