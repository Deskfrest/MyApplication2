//文章详情页面的数据模型
@Observed
class Article {
  //文章标题
  title: string
  //文章内容数组
  content: ArticleContent[]
  //采用option写法，可以在外部创建对象时，知道类对象需要的参数类型
  constructor(option: {
    title: string,
    content: ArticleContent[]
  }) {
    this.title = option.title
    this.content = option.content
  }
}

class ArticleContent {
  contentIndex: number
  contentType: string //类型区分 text 为文字 image 为图像
  contentText: string //传入文字内容或图片url
  contentImage: Resource

  constructor(option: {
    contentIndex: number,
    contentType: string,
    contentText: string,
    contentImage: Resource
  }) {
    this.contentIndex = option.contentIndex
    this.contentType = option.contentType
    this.contentText = option.contentText
    this.contentImage = option.contentImage
  }
}

export { Article, ArticleContent }