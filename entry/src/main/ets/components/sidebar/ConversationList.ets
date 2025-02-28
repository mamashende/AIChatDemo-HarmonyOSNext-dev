import {ConversationTabBar} from "./ConversationTabBar"
import {ConversationBasicInfo} from "../../common/entities/ConversationBasicInfo"
import {RandomUtil} from  '@pura/harmony-utils'
import {createNewTabInfo} from "../../common/functions/sideBar/TabBar"
import { AppStorageV2 } from '@kit.ArkUI';
import {ConvList} from "../../common/class/ConvListClass"
import {KvUtil,ToastUtil} from '@pura/harmony-utils'
import {ConversationID} from "../../common/class/ConversationID"


@ComponentV2
@Preview
export struct ConversationList {
  //@Local conversationTitleList : string[] = [];
  //@Local counter : number = 1;
  initInfo : ConversationBasicInfo = createNewTabInfo()
  //@Local conversationInfoList : ConversationBasicInfo[] = [this.initInfo]
  @Local  currentID : ConversationID = new ConversationID()
  @Event clickAndSwitch : (id : string) => void = () => {};
  @Local  covList :ConvList = new ConvList()
  //@Param  localvisibility :Visibility = Visibility.Visible
  async  aboutToAppear(): Promise<void> {

    this.covList = await ConvList.create()
    this.currentID.id = this.covList.currentConvID
    ToastUtil.showLong(JSON.stringify(this.currentID))

    console.log("chat inspect in conv",JSON.stringify(this.currentID))
    if (this.covList.currentConvID === '') {

      this.covList.conversationInfoList.unshift(this.initInfo)
      this.covList.currentConvID = this.initInfo.id
    }


  }

  build() {
    Column(){
      List({space:10}){
        ForEach(this.covList.conversationInfoList,(item : ConversationBasicInfo,index ?: number)=> {
          ListItem(){
            ConversationTabBar({info:item,deleteSelf:( id : string) => {//delete that item onClick
                let index = this.covList.conversationInfoList.findIndex(item => item.id = id)
                this.covList.conversationInfoList.splice(index,1)
                if (this.covList.conversationInfoList.length !== 0) {
                  this.covList.currentConvID = this.covList.conversationInfoList[0].id;
                  this.currentID.id = this.covList.currentConvID
                } else {
                  let temp = createNewTabInfo()
                  this.covList.conversationInfoList.unshift(temp)
                  this.covList.currentConvID = temp.id
                  this.currentID.id = this.covList.currentConvID
                }
              },
              clickAndSwitch : (id : string) => {//switch currentConvID onClick
                  this.covList.currentConvID = id
                  this.currentID.id = this.covList.currentConvID
                  console.log("gcb28",this.currentID.id)
              }
            })
          }
        })
      }
      .height("90%")
      Button("New")
        .onClick(() => {
          let temp = createNewTabInfo()
          this.covList.conversationInfoList.unshift(temp)
          this.covList.currentConvID = temp.id
          this.currentID.id = temp.id
          console.log("gcb28",JSON.stringify(this.covList))
          //this.conversationTitleList.push(`对话${this.counter}`)
          //this.counter += 1;
        })
    }


  }
}