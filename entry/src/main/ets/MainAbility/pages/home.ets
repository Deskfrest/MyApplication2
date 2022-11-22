import MyGrid from "../common/components/myGrid"
import MyGridContainer from "../common/components/myGridContainer"

@Entry
@Component
struct Home {
  @State btnList: number[] = [
    1, 2, 3, 4, 5, 6, 7, 8
  ]

  build() {
    Column() {
//      普通表格布局
//      MyGrid({ btnList: $btnList })
//      栅格布局
      MyGridContainer()
    }
  }
}