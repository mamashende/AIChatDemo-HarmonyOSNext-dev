import { makeChat } from "../api/OpenAIChat"
import { ConversationList } from "../components/sidebar/ConversationList"
import { MainPage } from "../components/chat/Chat"
import { ConversationID } from "../common/class/ConversationID"
import { AppStorageV2 } from "@kit.ArkUI"
import { ConvDetail } from "../common/class/ConvDetailClass"
import { hilog } from "@kit.PerformanceAnalysisKit"

import { testBoard } from "../components/test/testBoard"

@Entry
@ComponentV2
struct Index {
  @Local currntConvDetail: ConvDetail = new ConvDetail();
  @Local currentID: ConversationID = AppStorageV2.connect(ConversationID, () => new ConversationID())!;
  @Local localvisibility: Visibility = Visibility.Visible
  @Local switchButttomStatus: number = 0;

  //  @Local Visibility :
  async aboutToAppear(): Promise<void> {
    this.currntConvDetail = await ConvDetail.create(this.currentID.conversationId)
    //this.currentID =
    hilog.info(1, "test for currntConvDetail ", this.currentID.conversationId);
  }

  build() {
    RelativeContainer() {


      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          //MyCounter()

          MainPage({ currntConvDetail: this.currntConvDetail })


        }
        .width("100%")
        .height("100%")

        //侧边栏
        Column() {
          //显隐控制按钮
          Toggle({ type: ToggleType.Button, isOn: true }) {
            Text('status button').fontColor('#182431').fontSize(12)
          }
          .selectedColor(Color.Blue)
          .switchPointColor(Color.Gray)
          .onChange((isOn: boolean = true) => {
            if (isOn === true) {
              this.localvisibility = Visibility.Visible
            } else {
              this.localvisibility = Visibility.Hidden
            }
          })


          Column() {

            ConversationList({
              clickAndSwitchContent: async (id: string) => {
                this.currntConvDetail = await ConvDetail.create(id)
                this.switchButttomStatus += 1;
                //hilog.info(0,"switch test",this.currntConvDetail.messages.toString())
              }

            })
              .visibility(this.localvisibility)
          }

        }
        .width("70%")
        .height("100%")

      }
      testBoard({displayMessage:this.switchButttomStatus.toString()}).onClick(() => {
        this.switchButttomStatus += 1;
      })
    }
    .height('100%')
    .width('100%')


  }
}