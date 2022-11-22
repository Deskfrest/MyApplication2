@Component
struct MyGridContainer {
  build() {
    Column() {
      GridContainer({ columns: 12, gutter: 5, margin: 9 }) {


      }
      .width("100%")
      .height("200")
      .border({ width: 1, color: "#000" })
    }
    .padding(10)
  }
}

export default MyGridContainer