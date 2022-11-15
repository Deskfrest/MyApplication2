class Model {
  value: string

  constructor(value: string) {
    this.value = value
  }
}

@Component
struct MyComponent {
  @State title: Model = { value: 'Hello World' }
  @State count: number = 0
  private toggle: string = 'Hello World'
  private increaseBy: number = 1

  build() {
    Column() {
      Text(`${this.title.value}`).fontSize(30)
      Button('点击改变标题')
        .margin(20)
        .onClick(() => {
          this.title.value = (this.toggle == this.title.value) ? 'Hello World' : 'Hello ArkUI'
        })
      Divider()
      Button(`改变数字${this.count}`)
        .margin(20)
        .onClick(() => {
          this.count += this.increaseBy
        })
    }
  }
}

@Entry
@Component
struct EntryMyComponent {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        MyComponent()
      }
      .width('100%')
    }
    .height('100%')
  }
}