import MyGrid from "../common/components/myGrid"
import MyGridContainer from "../common/components/myGridContainer"
import MyListItem from "../common/components/myListItem"
import display from '@ohos.display';

@Entry
@Component
struct Home {
  @State btnList: number[] = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
  ]
  private width: number
  @State height: number = 0

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

    Stack({ alignContent: Alignment.TopStart }) {
      //      普通表格布局
      //      MyGrid({ btnList: $btnList })
      //      栅格布局


      MyGridContainer()
      List({ space: 5 }) {
        ForEach(this.btnList, (item, index) => {
          ListItem() {
            MyListItem({ index: item })
          }
        }, item => item)
      }
      .width("100%")
      //      .height(this.height - 10 - 85 - 5 - 40)
      .border({ width: 1 })
      .edgeEffect(EdgeEffect.None) // 滑动到边缘无效果
      .margin({ top: 10 + 85 + 5 + 40 })

    }
    .width("100%")
    .height("100%")
    .padding(1)
  }
}