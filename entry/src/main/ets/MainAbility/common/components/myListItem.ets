@Component
struct MyListItem {
  private index: number

  build() {
    GridContainer({ columns: 12, gutter: 20, margin: 5 }) {
      Row() {
        Image($r('app.media.icon'))
          .width("100%")
          .height(60)
          .borderRadius(15)
          .useSizeType({
            sm: { span: 3, offset: 0 },
            md: { span: 4, offset: 0 }
          })
          .objectFit(ImageFit.Cover)
        Column() {
          Text("标题标题标题标题标题标题标题标题")
            .fontSize(16)
            .width("100%")
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
          Text("2022-11-" + this.index)
            .fontSize(14)
            .lineHeight(35)
            .width("100%")
            .fontWeight(400)
        }
        .useSizeType({
          sm: { span: 6, offset: 3 },
          md: { span: 5, offset: 4 }
        })

        Row() {
          Image($r('app.media.icon'))
            .width(30)
            .height(30)
            .objectFit(ImageFit.Cover)
        }
        .useSizeType({
          sm: { span: 3, offset: 9 },
          md: { span: 3, offset: 9 }
        })
      }
      .width("100%")
      .padding(5)
    }
    .border({ width: 5, color: "#ffb5b5b5" })
    .borderRadius(15)
  }
}

export default MyListItem