// @ts-nocheck
import http from '@ohos.net.http';
import ResponseCode from '@ohos.net.http';
import image from '@ohos.multimedia.image'


@Entry
@Component
struct Index {

  // 先创建一个PixelMap状态变量用于接收网络图片
  @State imageMy: PixelMap = undefined

  build() {
    Column({ space: 10 }) {
      Button("获取网络图片")
        .onClick(() => {
          this.httpRequest();
        })
      Image(this.image)
        .height(100)
        .width(100)
        .alt($r('app.media.ic_launcher'))
        .objectFit(ImageFit.Contain)
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }

  // 网络图片请求方法
  private httpRequest() {
    let httpRequest = http.createHttp();

    httpRequest.request(
      "https://images.pexels.com/photos/7858743/pexels-photo-7858743.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", // 请填写一个具体的网络图片地址
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {},
        connectTimeout: 60000, // 可选，默认为60s
        readTimeout: 60000, // 可选，默认为60s
      },
      (error, data) => {
        if (error) {
          console.log("error code: " + error.code + ", msg: " + error.message)
        } else {
          // data.header为http响应头，可根据业务需要进行解析
          console.info('header:' + JSON.stringify(data.header));
          let code = data.responseCode
          if (ResponseCode.ResponseCode.OK == code) {
            console.info("ResponseCode.ResponseCode.OK=" + ResponseCode.ResponseCode.OK)
            console.info("code=" + ResponseCode.ResponseCode.OK)
            let resultArrayBuffer = data.result as string
            let resultArrayBufferLength = new ArrayBuffer(1687500)
            //            size: { height: 100, width: 100 }

            let lengthMy = resultArrayBuffer.byteLength
            console.info("resultArrayBuffer=" + resultArrayBuffer.length)
            let options = {
              alphaType: 0, // 透明度
              editable: true, // 是否可编辑
              pixelFormat: 2, // 像素格式
              scaleMode: 1, // 缩略值
              size: { height: 750, width: 1125 }
            } // 创建图片大小
            image.createPixelMap(resultArrayBufferLength, options).then((pixelMap) => {
              pixelMap.writeBufferToPixels(resultArrayBufferLength).then(() => {
                console.log("Succeeded in writing data from a buffer to a PixelMap.");
                this.imageMy=pixelMap
//                pixelMap.getImageInfo().then((data) => {
//                  console.info("data.size.width=" + data.size.width)
//                  console.info("data.size.height=" + data.size.height)
//                  data.size.height
//                })
              }).catch((err) => {
                console.error("Failed to write data from a buffer to a PixelMap."+err);
              })

            })
          } else {
            console.log("response code: " + code);
          }
        }
      }
    )
  }
}