@Component
struct MyInput {
  @Link inputValue: string
  @Prop placeholder: string
  @Prop lable: string
  private type: InputType = InputType.Normal

  build() {
    Row({ space: 5 }) {
      Text(this.lable)
        .fontSize(20)
        .width("20%")
        .textAlign(TextAlign.Center)
      TextInput({ placeholder: this.placeholder, text: this.inputValue })
        .onChange((value: string) => {
          this.inputValue = value
        })
        .width("80%")
        .height(40)
        .margin({ top: 5 })
        .border({ width: 1, color: "#000" })
        .borderRadius(20)
        .backgroundColor("#fff")
        .type(this.type)
    }
  }
}

export default MyInput