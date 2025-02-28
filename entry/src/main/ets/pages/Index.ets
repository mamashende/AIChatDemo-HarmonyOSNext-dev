import {makeChat} from "../api/OpenAIChat"
import {ConversationList} from "../components/sidebar/ConversationList"
import {MainPage} from "../components/chat/Chat"
import {ConversationID} from "../common/class/ConversationID"
import { AppStorageV2 } from "@kit.ArkUI"

@Entry
@ComponentV2
struct Index {

  @Local currentID : ConversationID = new ConversationID();
  aboutToAppear(): void {
    this.currentID = AppStorageV2.connect(ConversationID,() => new ConversationID())!;
    //this.currentID.id = "114514"
    console.log("chat inspect in index",JSON.stringify(this.currentID))
  }
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