import {makeChat} from "../api/OpenAIChat"
import {ConversationList} from "../components/sidebar/ConversationList"
import {MainPage} from "../components/chat/Chat"
import {ConversationID} from "../common/class/ConversationID"
import { AppStorageV2 } from "@kit.ArkUI"



@Entry
@ComponentV2
struct Index {

  //@Local currentID : ConversationID = new ConversationID();
  @Local  localvisibility :Visibility = Visibility.Visible
  @Local switchButttomStatus : boolean = false;
//  @Local Visibility :
  aboutToAppear(): void {
    //this.currentID = AppStorageV2.connect(ConversationID,() => new ConversationID())!;
    //this.currentID.id = "114514"
    //console.log("chat inspect in index",JSON.stringify(this.currentID))
  }
  build() {
    RelativeContainer() {

      Stack({alignContent:Alignment.TopStart}){
        Column(){
          //MyCounter()
          MainPage()

        }
        .width("100%")
        .height("100%")

        //侧边栏
        Column(){
          //显隐控制按钮
          Toggle({type: ToggleType.Button,isOn : this.switchButttomStatus}) {
            Text('status button').fontColor('#182431').fontSize(12)
          }
            .selectedColor(Color.Blue)
            .switchPointColor(Color.Gray)
            .onChange((isOn : boolean) => {
              if (isOn === true) {
                this.localvisibility = Visibility.Visible
              } else {
                this.localvisibility = Visibility.Hidden
              }
            })


          Column(){
            ConversationList()
              .visibility(this.localvisibility)
          }


        }
        .width("70%")
        .height("100%")



      }



    }
    .height('100%')
    .width('100%')
  }
}