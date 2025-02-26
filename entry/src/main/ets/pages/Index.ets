import {makeChat} from "../api/OpenAIChat"
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {


      Text(this.message).height('100%')
        .width('100%')
        .onClick(async  () => {
          let temp  = await makeChat({model:"qwen-plus"},[{role:"user",content:"who are you"}])
          this.message = temp.content;
        })
    }
    .height('100%')
    .width('100%')
  }
}