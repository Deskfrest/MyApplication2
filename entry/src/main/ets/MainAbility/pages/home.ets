import MyGrid from "../common/components/myGrid"
import MyGridContainer from "../common/components/myGridContainer"
import display from '@ohos.display';

@Entry
@Component
struct Home {
  @State btnList: number[] = [
    1, 2, 3, 4, 5, 6, 7, 8
  ]
  private width: number
  private height: number

  onPageShow() {
    var displayClass = null;
    let promise = display.getDefaultDisplay();
    promise.then((data) => {
      displayClass = data;
      this.width = data.width
      this.height = data.height

      console.info(`width=${px2vp(this.width)}  height=${px2vp(this.height)}`);
    }).catch((err) => {
      console.error('Failed to obtain the default display object. Code:  ' + JSON.stringify(err));
    });
  }

  build() {

    Column() {
      //      普通表格布局
      //      MyGrid({ btnList: $btnList })
      //      栅格布局
      MyGridContainer()

      Scroll() {

        Button(this.height+"")
          .height(this.height)
      }
      .height(this.height - 10 - 85 - 5 - 40)
      .border({ width: 10 })
    }
    .padding(10)
  }
}