import {makeChat} from "../api/OpenAIChat"
import {ConversationList} from "../components/sidebar/ConversationList"
import {MainPage} from "../components/chat/Chat"
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {

      SideBarContainer(SideBarContainerType.Overlay){
        Column(){

          ConversationList()
        }
        .width("30%")
        .height("100%")


        Column(){
          //MyCounter()
          MainPage()

        }
        .width("100%")
        .height("100%")
      }



    }
    .height('100%')
    .width('100%')
  }
}