import MyInput from "../common/components/myinput"
import router from '@ohos.router'

@Entry
@Component
struct login {
  @State username: string = "12351z5"
  @State password: string = ""
  private username_reg = /^[A-Za-z0-9]{5,8}$/;

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Text("登录")
        .fontSize(40)
        .fontWeight(500)

      if (!this.username_reg.test(this.username)) {
        Text("用户名不规范")
          .fontSize(12)
          .fontColor(Color.Red)
          .fontWeight(500)
      }

      MyInput({
        placeholder: "请输入用户名",
        inputValue: $username,
        lable: "用户名",
        type: InputType.Normal
      })

      MyInput({
        placeholder: "请输入密码",
        inputValue: $password,
        lable: "密码",
        type: InputType.Password
      })

      Button("进入")
        .margin({ top: 10 })
        .onClick(() => {
          router.push({
            url: "pages/home"
          })
        })
    }
    .width("100%")
    .height("100%")
    .border({ color: "#ff7a0000", width: 10 })
    .padding(10)
  }
}