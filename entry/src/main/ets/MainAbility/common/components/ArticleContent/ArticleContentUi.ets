import { Article } from "../../bean/Article";
import ContentItemUi from "./ContentItemUi"

@Component
struct ArticleContentUi {
  @Consume("article") article: Article
  @State userClick: number = -1

  build() {
    Column() {
      ForEach(this.article.content, (item, index) => {
        ContentItemUi({
          article: this.article,
          contentIndex: item.contentIndex,
          contentType: item.contentType,
          contentText: item.contentText,
          contentImage: item.contentImage,
          userClick: $userClick
        })
      })
    }
  }
}

export default ArticleContentUi