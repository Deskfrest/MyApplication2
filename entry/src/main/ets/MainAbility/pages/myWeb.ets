import http from '@ohos.net.http'

@Entry
@Component
struct MyWeb {
  controller: WebController = new WebController();
  @State mode: MixedMode = MixedMode.All

  //发送post请求
  sendAutoPost(code: string) {
    // 每一个httpRequest对应一个http请求任务，不可复用
    let httpRequest = http.createHttp();

    // 用于订阅http响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    // 从API 8开始，使用on('headersReceive', Callback)替代on('headerReceive', AsyncCallback)。 8+
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

//    httpRequest.request(
//      // 填写http请求的url地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
//      "http://baike.baidu.com/api/openapi/BaikeLemmaCardApi?",
//      {
//        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
//        // 开发者根据自身业务需要添加header字段
//        header: {
//          'Content-Type': 'application/json'
//        },
//        // 当使用POST请求时此字段用于传递内容
//        extraData: {
//          "scope": 103,
//          "format": "json",
//          "appid": 379020,
//          "bk_key": "关键字",
//          "bk_length":600
//        },
//        connectTimeout: 60000, // 可选，默认为60s
//        readTimeout: 60000, // 可选，默认为60s
//      }, (err, data) => {
//      if (!err) {
//        // data.result为http响应内容，可根据业务需要进行解析
//        console.info('onUrlLoadIntercept Result:' + data.result);
//        console.info('onUrlLoadIntercept code:' + data.responseCode);
//        // data.header为http响应头，可根据业务需要进行解析
//        console.info('onUrlLoadIntercept header:' + JSON.stringify(data.header));
//        console.info('onUrlLoadIntercept cookies:' + data.cookies); // 8+
//      } else {
//        console.info('onUrlLoadIntercept error:' + JSON.stringify(err));
//        // 当该请求使用完毕时，调用destroy方法主动销毁。
//        httpRequest.destroy();
//      }
//    });

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
        // data.result为http响应内容，可根据业务需要进行解析
        console.info('onUrlLoadIntercept Result:' + data.result);
        //Result
        //{"access_token":"v0SX_nt7ia8h3vC-IW4sAWbcUwa8-Uc67CoDks1h9r0","expires_in":3600,"token_type":"bearer","scope":"","refresh_token":"TBx7N452GnGLTDmZYgygPQSON8F2xvpdeAb5fWNcsD4","user":{"profile_image_urls":{"px_16x16":"https:\/\/s.pximg.net\/common\/images\/no_profile_ss.png","px_50x50":"https:\/\/s.pximg.net\/common\/images\/no_profile_s.png","px_170x170":"https:\/\/s.pximg.net\/common\/images\/no_profile.png"},"id":"78240265","name":"root_z","account":"user_urjv3774","mail_address":"zyrmingzufuxing@gmail.com","is_premium":false,"x_restrict":2,"is_mail_authorized":true,"require_policy_agreement":true},"response":{"access_token":"v0SX_nt7ia8h3vC-IW4sAWbcUwa8-Uc67CoDks1h9r0","expires_in":3600,"token_type":"bearer","scope":"","refresh_token":"TBx7N452GnGLTDmZYgygPQSON8F2xvpdeAb5fWNcsD4","user":{"profile_image_urls":{"px_16x16":"https:\/\/s.pximg.net\/common\/images\/no_profile_ss.png","px_50x50":"https:\/\/s.pximg.net\/common\/images\/no_profile_s.png","px_170x170":"https:\/\/s.pximg.net\/common\/images\/no_profile.png"},"id":"78240265","name":"root_z","account":"user_urjv3774","mail_address":"zyrmingzufuxing@gmail.com","is_premium":false,"x_restrict":2,"is_mail_authorized":true,"require_policy_agreement":true}}}
        console.info('onUrlLoadIntercept code:' + data.responseCode);
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
    .width("100%")
    .height("100%")
  }
}