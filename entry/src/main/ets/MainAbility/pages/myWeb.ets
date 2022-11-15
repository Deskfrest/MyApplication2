import http from '@ohos.net.http'
import huks from '@ohos.security.huks'
import ResponseCode from '@ohos.net.http';
import image from '@ohos.multimedia.image'

@Entry
@Component
struct MyWeb {
  controller: WebController = new WebController();
  @State mode: MixedMode = MixedMode.All
  // 先创建一个PixelMap状态变量用于接收网络图片
  @State image: PixelMap = undefined

  loadOneImage(imageUrl: string) {
    const date = new Date();
    //RFC 3339 格式日期
    const xClientTime = date.toISOString();
    console.info("onUrlLoadIntercept xClientTime=" + xClientTime)
    var MD5 = function (d) {
      var r = M(V(Y(X(d), 8 * d.length)));
      return r.toLowerCase()
    };

    function M(d) {
      for (var _, m = "0123456789ABCDEF", f = "",
        r = 0;r < d.length; r++) _ = d.charCodeAt(r), f += m.charAt(_ >>> 4 & 15) + m.charAt(15 & _);
      return f
    }

    function X(d) {
      for (var _ = Array(d.length >> 2), m = 0;m < _.length; m++) _[m] = 0;
      for (m = 0; m < 8 * d.length; m += 8) _[m>>5] |= (255 & d.charCodeAt(m / 8)) << m % 32;
      return _
    }

    function V(d) {
      for (var _ = "", m = 0;m < 32 * d.length; m += 8) _ += String.fromCharCode(d[m>>5] >>> m % 32 & 255);
      return _
    }

    function Y(d, _) {
      d[_>>5] |= 128 << _ % 32, d[14+(_ + 64 >>> 9 << 4)] = _;
      for (var m = 1732584193, f = -271733879, r = -1732584194, i = 271733878, n = 0;n < d.length; n += 16) {
        var h = m, t = f, g = r, e = i;
        f = md5_ii(f = md5_ii(f = md5_ii(f = md5_ii(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_hh(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_gg(f = md5_ff(f = md5_ff(f = md5_ff(f = md5_ff(f, r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n+0], 7, -680876936), f, r, d[n+1], 12, -389564586), m, f, d[n+2], 17, 606105819), i, m, d[n+3], 22, -1044525330), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n+4], 7, -176418897), f, r, d[n+5], 12, 1200080426), m, f, d[n+6], 17, -1473231341), i, m, d[n+7], 22, -45705983), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n+8], 7, 1770035416), f, r, d[n+9], 12, -1958414417), m, f, d[n+10], 17, -42063), i, m, d[n+11], 22, -1990404162), r = md5_ff(r, i = md5_ff(i, m = md5_ff(m, f, r, i, d[n+12], 7, 1804603682), f, r, d[n+13], 12, -40341101), m, f, d[n+14], 17, -1502002290), i, m, d[n+15], 22, 1236535329), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n+1], 5, -165796510), f, r, d[n+6], 9, -1069501632), m, f, d[n+11], 14, 643717713), i, m, d[n+0], 20, -373897302), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n+5], 5, -701558691), f, r, d[n+10], 9, 38016083), m, f, d[n+15], 14, -660478335), i, m, d[n+4], 20, -405537848), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n+9], 5, 568446438), f, r, d[n+14], 9, -1019803690), m, f, d[n+3], 14, -187363961), i, m, d[n+8], 20, 1163531501), r = md5_gg(r, i = md5_gg(i, m = md5_gg(m, f, r, i, d[n+13], 5, -1444681467), f, r, d[n+2], 9, -51403784), m, f, d[n+7], 14, 1735328473), i, m, d[n+12], 20, -1926607734), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n+5], 4, -378558), f, r, d[n+8], 11, -2022574463), m, f, d[n+11], 16, 1839030562), i, m, d[n+14], 23, -35309556), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n+1], 4, -1530992060), f, r, d[n+4], 11, 1272893353), m, f, d[n+7], 16, -155497632), i, m, d[n+10], 23, -1094730640), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n+13], 4, 681279174), f, r, d[n+0], 11, -358537222), m, f, d[n+3], 16, -722521979), i, m, d[n+6], 23, 76029189), r = md5_hh(r, i = md5_hh(i, m = md5_hh(m, f, r, i, d[n+9], 4, -640364487), f, r, d[n+12], 11, -421815835), m, f, d[n+15], 16, 530742520), i, m, d[n+2], 23, -995338651), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n+0], 6, -198630844), f, r, d[n+7], 10, 1126891415), m, f, d[n+14], 15, -1416354905), i, m, d[n+5], 21, -57434055), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n+12], 6, 1700485571), f, r, d[n+3], 10, -1894986606), m, f, d[n+10], 15, -1051523), i, m, d[n+1], 21, -2054922799), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n+8], 6, 1873313359), f, r, d[n+15], 10, -30611744), m, f, d[n+6], 15, -1560198380), i, m, d[n+13], 21, 1309151649), r = md5_ii(r, i = md5_ii(i, m = md5_ii(m, f, r, i, d[n+4], 6, -145523070), f, r, d[n+11], 10, -1120210379), m, f, d[n+2], 15, 718787259), i, m, d[n+9], 21, -343485551), m = safe_add(m, h), f = safe_add(f, t), r = safe_add(r, g), i = safe_add(i, e)
      }
      return Array(m, f, r, i)
    }

    function md5_cmn(d, _, m, f, r, i) {
      return safe_add(bit_rol(safe_add(safe_add(_, d), safe_add(f, i)), r), m)
    }

    function md5_ff(d, _, m, f, r, i, n) {
      return md5_cmn(_ & m | ~_ & f, d, _, r, i, n)
    }

    function md5_gg(d, _, m, f, r, i, n) {
      return md5_cmn(_ & f | m & ~f, d, _, r, i, n)
    }

    function md5_hh(d, _, m, f, r, i, n) {
      return md5_cmn(_ ^ m ^ f, d, _, r, i, n)
    }

    function md5_ii(d, _, m, f, r, i, n) {
      return md5_cmn(m ^ (_ | ~f), d, _, r, i, n)
    }

    function safe_add(d, _) {
      var m = (65535 & d) + (65535 & _);
      return (d >> 16) + (_ >> 16) + (m >> 16) << 16 | 65535 & m
    }

    function bit_rol(d, _) {
      return d << _ | d >>> 32 - _
    }

    const xClientHash = MD5(`${xClientTime}28c1fdd170a5204386cb1313c7077b34f83e4aaf4aa829ce78c231e05b0bae2c`);
    console.info("onUrlLoadIntercept xClientHash=" + xClientHash)

    // 每一个httpRequest对应一个http请求任务，不可复用
    let httpRequest = http.createHttp();

    // 用于订阅http响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    httpRequest.request(
      // 填写http请求的url地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      imageUrl,
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {
          "referer": "https://app-api.pixiv.net/",
          "x-client-time": xClientTime,
          "x-client-hash": xClientHash,
          "User-Agent": "PixivIOSApp/5.8.0"
        },
        connectTimeout: 60000, // 可选，默认为60s
        readTimeout: 60000, // 可选，默认为60s
      }, (error, data) => {
      if (error) {
        console.info("onUrlLoadIntercept image error code: " + error.code + ", msg: " + error.message)
      } else {
        let code = data.responseCode
        let result = data.result as string
        console.info("onUrlLoadIntercept image code=" + code+" result="+result)
        if (ResponseCode.ResponseCode.OK == code) {
          let imageSource = image.createImageSource(data.result as string)
          let options = {
            alphaType: 0, // 透明度
            editable: false, // 是否可编辑
            pixelFormat: 3, // 像素格式
            scaleMode: 1, // 缩略值
            size: { height: 100, width: 100 }
          } // 创建图片大小
          imageSource.createPixelMap(options).then((pixelMap) => {
            this.image = pixelMap
          })
        } else {
          console.log("onUrlLoadIntercept image response code: " + code);
        }
      }
    });
  }

  getGallery(option: { access_token: string }) {
    // 每一个httpRequest对应一个http请求任务，不可复用
    let httpRequest = http.createHttp();

    // 用于订阅http响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    httpRequest.request(
      // 填写http请求的url地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      "https://app-api.pixiv.net/v1/illust/recommended?include_privacy_policy=true&filter=for_android&include_ranking_illusts=true",
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {
          'Authorization': option.access_token
        },
        connectTimeout: 60000, // 可选，默认为60s
        readTimeout: 60000, // 可选，默认为60s
      }, (err, data) => {
      if (!err) {
        let responseCode = data.responseCode
        let result = data.result as string
        console.info('onUrlLoadIntercept code:' + responseCode);
        // data.result为http响应内容，可根据业务需要进行解析
        console.info('onUrlLoadIntercept Result:' + result);
        //Result
        const resultContentUrl = JSON.parse(result).illusts[0].image_urls.medium
        console.info("onUrlLoadIntercept resultContent=" + resultContentUrl)
        this.loadOneImage(resultContentUrl)
        // data.header为http响应头，可根据业务需要进行解析
        console.info('onUrlLoadIntercept header:' + JSON.stringify(data.header));
        console.info('onUrlLoadIntercept cookies:' + data.cookies); // 8+
      } else {
        console.info('onUrlLoadIntercept error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    });
  }

  //发送post请求
  sendAutoPost(code: string) {
    // 每一个httpRequest对应一个http请求任务，不可复用
    let httpRequest = http.createHttp();

    // 用于订阅http响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    httpRequest.request(
      // 填写http请求的url地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      "https://oauth.secure.pixiv.net/auth/token",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "client_id": "MOBrBDS8blbauoSck0ZfDbtuzpyT",
          "client_secret": "lsACyCD94FhDUtGTXi3QzcFE2uU1hqtDaKeqrdwj",
          "grant_type": "authorization_code",
          "code": code,
          "code_verifier": "MmE4I6YcglVzSHnwlNvBlsEwxRpUUaqvh4GxmQqoItw",
          "redirect_uri": "https://app-api.pixiv.net/web/v1/users/auth/pixiv/callback",
          "include_policy": true
        },
        connectTimeout: 60000, // 可选，默认为60s
        readTimeout: 60000, // 可选，默认为60s
      }, (err, data) => {
      if (!err) {
        let responseCode = data.responseCode
        let result = data.result as string
        if (responseCode == 200) {
          //成功获取到access_token，进行下一步操作
          let access_token = JSON.parse(result).access_token
          console.info('onUrlLoadIntercept access_token=' + access_token)
          this.getGallery({ access_token: "Bearer " + access_token })
        } else if (responseCode == 400 && result.search("Error occurred at the OAuth process") != -1) {
          //此情况表示access_token已经过期，需要使用refresh_token重新请求新的access_token
        }
        console.info('onUrlLoadIntercept code:' + responseCode);
        // data.result为http响应内容，可根据业务需要进行解析
        console.info('onUrlLoadIntercept Result:' + data.result);
        //Result
        //{"access_token":"v0SX_nt7ia8h3vC-IW4sAWbcUwa8-Uc67CoDks1h9r0","expires_in":3600,"token_type":"bearer","scope":"","refresh_token":"TBx7N452GnGLTDmZYgygPQSON8F2xvpdeAb5fWNcsD4","user":{"profile_image_urls":{"px_16x16":"https:\/\/s.pximg.net\/common\/images\/no_profile_ss.png","px_50x50":"https:\/\/s.pximg.net\/common\/images\/no_profile_s.png","px_170x170":"https:\/\/s.pximg.net\/common\/images\/no_profile.png"},"id":"78240265","name":"root_z","account":"user_urjv3774","mail_address":"zyrmingzufuxing@gmail.com","is_premium":false,"x_restrict":2,"is_mail_authorized":true,"require_policy_agreement":true},"response":{"access_token":"v0SX_nt7ia8h3vC-IW4sAWbcUwa8-Uc67CoDks1h9r0","expires_in":3600,"token_type":"bearer","scope":"","refresh_token":"TBx7N452GnGLTDmZYgygPQSON8F2xvpdeAb5fWNcsD4","user":{"profile_image_urls":{"px_16x16":"https:\/\/s.pximg.net\/common\/images\/no_profile_ss.png","px_50x50":"https:\/\/s.pximg.net\/common\/images\/no_profile_s.png","px_170x170":"https:\/\/s.pximg.net\/common\/images\/no_profile.png"},"id":"78240265","name":"root_z","account":"user_urjv3774","mail_address":"zyrmingzufuxing@gmail.com","is_premium":false,"x_restrict":2,"is_mail_authorized":true,"require_policy_agreement":true}}}
        //access_token即为需要的用户token，拼装Bearer头部后即可使用
        // data.header为http响应头，可根据业务需要进行解析
        console.info('onUrlLoadIntercept header:' + JSON.stringify(data.header));
        console.info('onUrlLoadIntercept cookies:' + data.cookies); // 8+
      } else {
        console.info('onUrlLoadIntercept error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    });

  }

  //  generateCodeVerifier(){
  //    n = n || 16;
  //    var result = '';
  //    while (n--){
  //      result += Math.floor(Math.random()*16).toString(16).toUpperCase();
  //    }
  //    return result;
  //  }

  getQueryVariable(
    key: string,
    url: string
  ) {
    console.log(`onUrlLoadIntercept key=${key} url=${url}`)
    let head = url.split('?')[0]
    let p = url.split('?')[1]
    let isTrueHeaderUrl = false
    if (head.search("pixiv://account/login") != -1) {
      isTrueHeaderUrl = true
    }
    let keyValue = p.split('&');
    let obj = {};
    for (let i = 0; i < keyValue.length; i++) {
      let item = keyValue[i].split('=');
      let key = item[0];
      let value = item[1];
      obj[key] = value;

    }
    let code = obj['code'] as string
    console.log("onUrlLoadIntercept code=" + code)
    if (code != "undefined" && code.length > 0 && isTrueHeaderUrl) {
      this.sendAutoPost(code)
    }
  }

  build() {
    Column() {
      Stack() {
        Image(this.image)
          .height("30%")
          .width("30%")
          .objectFit(ImageFit.Contain)
        //        Web({
        //          src: 'https://www.baidu.com/',
        //          controller: this.controller
        //        })
        //          .mixedMode(this.mode)
        //          .onUrlLoadIntercept((event) => {
        //
        //            return false;
        //          })
        Web({
          src: 'https://app-api.pixiv.net/web/v1/login?code_challenge=8Js-YwPBlINgU4Gfkf2VSJuX0nCHcJkoOVJ0JzY_Je0&code_challenge_method=S256&client=pixiv-android',
          //        src:'https://www.baidu.com/',
          controller: this.controller
        })
          .mixedMode(this.mode)
          .onUrlLoadIntercept((event) => {

            let webResourceRequest = event.data as WebResourceRequest
            // webResourceRequest.getRequestUrl()=pixiv://account/login?code=_gTc-9LvbSHiKV0IgQYQVHQwRni7CqsH2qng9zm8T34&via=login
            let url = webResourceRequest.getRequestUrl()
            console.log('onUrlLoadIntercept ' + url)
            //          console.log('onUrlLoadIntercept ' +url + " zyr")

            //          console.log("url="+url)
            this.getQueryVariable("code", url)

            return false;
          })
      }
    }
    .width("100%")
    .height("100%")
  }
}