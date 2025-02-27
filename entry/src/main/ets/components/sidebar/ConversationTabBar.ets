import {TabInfoBlock} from "./TabInfo"
import {ConversationBasicInfo} from "../../common/entities/ConversationBasicInfo"
import {ConvList} from "../../common/class/ConvListClass"
import { AppStorageV2 } from "@kit.ArkUI";
import {KvUtil,ToastUtil} from '@pura/harmony-utils'
@ComponentV2
@Preview
export struct ConversationTabBar {
  @Param info : ConversationBasicInfo = {id:'',title:'',createdAt:'',updatedAt:''}
  @Event deleteSelf : (id : string) => void = () => {};
  @Event clickAndSwitch : (id : string) => void = () => {}
  //convlist : ConvList  = AppStorageV2.connect(ConvList,() => new ConvList())!;

  aboutToAppear(): void {
    //ToastUtil.showLong(JSON.stringify(this.convlist))
    //console.log("gcb28 child",JSON.stringify(this.convlist.conversationInfoList.length))
  }
  build() {
    Column({space:10}){
      Button({type:ButtonType.Normal}){
        TabInfoBlock({info:this.info})
      }
      .borderRadius(20)
      .width('100%')
      .height('10%')
      .padding(10)
      .backgroundColor(Color.White)
      .onClick(() => {
          //this.convlist.currentConvID = this.info.id
          //ToastUtil.showToast(JSON.stringify(this.info))
        this.clickAndSwitch(this.info.id)
      })

      Button({type:ButtonType.Normal})
        .width('5%')
        .height('5%')
        .offset({
          x:80,
          y:-80
        })
        .borderRadius(100)
        .onClick(() => {
          //ToastUtil.showToast(JSON.stringify(this.convlist.conversationInfoList))
          this.deleteSelf(this.info.id)

        })
        .backgroundColor(Color.Gray)


    }
  }
}