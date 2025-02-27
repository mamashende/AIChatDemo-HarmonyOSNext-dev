import {ConversationTabBar} from "./ConversationTabBar"
import {ConversationBasicInfo} from "../../common/entities/ConversationBasicInfo"
import {RandomUtil} from  '@pura/harmony-utils'
import {createNewTabInfo} from "../../common/functions/sideBar/TabBar"
import { AppStorageV2 } from '@kit.ArkUI';
import {ConvList} from "../../common/class/ConvListClass"
import {KvUtil,ToastUtil} from '@pura/harmony-utils'
@ComponentV2
@Preview
export struct ConversationList {
  //@Local conversationTitleList : string[] = [];
  //@Local counter : number = 1;
  initInfo : ConversationBasicInfo = createNewTabInfo()
  //@Local conversationInfoList : ConversationBasicInfo[] = [this.initInfo]

  @Local covList :ConvList = new ConvList()
  async  aboutToAppear(): Promise<void> {
    this.covList = AppStorageV2.connect(ConvList,() => this.covList)!;
    this.covList = await ConvList.create()
    console.log("gcb28")
    console.log("gcb28",JSON.stringify(this.covList))
    console.log("gcb28",this.covList.currentConvID)
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
            if (item.id !== '')
            ConversationTabBar({info:item,deleteSelf:( id : string) => {//delete that item onClick
                let index = this.covList.conversationInfoList.findIndex(item => item.id = id)
                this.covList.conversationInfoList.splice(index,1)
                if (this.covList.conversationInfoList.length !== 0) {
                  this.covList.currentConvID = this.covList.conversationInfoList[0].id;
                }
              },
              clickAndSwitch : (id : string) => {//switch currentConvID onClick
                  this.covList.currentConvID = id
                  console.log("gcb28",this.covList.currentConvID)
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
          console.log("gcb28",JSON.stringify(this.covList))
          //this.conversationTitleList.push(`对话${this.counter}`)
          //this.counter += 1;
        })
    }

  }
}