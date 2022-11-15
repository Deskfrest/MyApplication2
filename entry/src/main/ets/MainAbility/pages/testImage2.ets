import image from '@ohos.multimedia.image'

@Entry
@Component
struct TestImage2 {
  @State message: string = 'Hello World'
  @State imageMy: PixelMap = undefined

  build() {
    Column({ space: 10 }) {
      Button("获取网络图片")
        .onClick(() => {
//          const color = new ArrayBuffer(96);
//          const pixelMap = new ArrayBuffer(400);
//          let bufferArr = new Uint88Array(color);
//          pixelMap.writeBufferToPixels(color).then(() => {
//            console.log("Succeeded in writing data from a buffer to a PixelMap.");
//          }).catch((err) => {
//            console.error("Failed to write data from a buffer to a PixelMap.");
//          })


          // 创建pixelmap对象
          const color = new ArrayBuffer(96);
          let bufferArr = new Uint8Array(color);
          let opts = { editable: true, pixelFormat: 3, size: { height: 4, width: 6 } }
          image.createPixelMap(color, opts)
            .then((pixelmap) => {
              console.info("awqdwqdqwdqwdqwd=" + pixelmap.isEditable)
              this.imageMy = pixelmap
              pixelmap.writeBufferToPixels(color).then(() => {
                console.log("Succeeded in writing data from a buffer to a PixelMap.");
              }).catch((err) => {
                console.error("Failed to write data from a buffer to a PixelMap.");
              })
            })
          //          this.httpRequest();
        })
      Image(this.imageMy)
        .height(100)
        .width(100)
        .alt($r('app.media.ic_launcher'))
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}