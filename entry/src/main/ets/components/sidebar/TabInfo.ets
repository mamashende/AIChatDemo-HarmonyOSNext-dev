import {ConversationBasicInfo} from "../../common/entities/ConversationBasicInfo"
@ComponentV2
@Preview
export struct TabInfoBlock {
  @Param info : ConversationBasicInfo = {id:'',title:'',createdAt:'',updatedAt:''}
  build() {
    Column(){
      Text(this.info.title)
        .fontSize(20)
      Text(this.info.createdAt)
        .fontSize(10)
    }
  }
}