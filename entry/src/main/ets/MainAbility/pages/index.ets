@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button('跳转')
          .margin(20)
          .onClick(()=>{

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}