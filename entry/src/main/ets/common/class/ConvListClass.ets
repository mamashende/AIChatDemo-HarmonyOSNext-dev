import {ConversationBasicInfo} from "../entities/ConversationBasicInfo"
import {KvUtil,ToastUtil} from '@pura/harmony-utils'
const MONITOR_PREFIX = "__ob_"
const USER_KEY_ConvList = "user_key_global_ConvList"
@ObservedV2
export class ConvList {
  @Trace
  conversationInfoList : Array<ConversationBasicInfo> = []

  @Trace
  currentConvID : string = ''
  // 监听属性值的变化做本地持久化操作
  @Monitor("conversationInfoList","currentConvID") notifyAttributeChanged(monitor: IMonitor){
    let value = JSON.stringify(this).replaceAll(MONITOR_PREFIX, "")
    console.log("user info: " + value)
    //KVManager.get().put(USER_KEY, value)
    KvUtil.put(USER_KEY_ConvList,value);

  }
  // 从本地磁盘取出缓存数据
  static async create(): Promise<ConvList> {
    let value = await KvUtil.get(USER_KEY_ConvList) as  string
    if (value.length < 1) {
      return new ConvList()
    }
    let object = JSON.parse(value) as ConvList
    let convlist = new ConvList();
    convlist.conversationInfoList = object.conversationInfoList
    convlist.currentConvID = object.currentConvID
    console.log("read check of currentConvID ",JSON.stringify(convlist.currentConvID))
    //ToastUtil.showToast(JSON.stringify(convlist))
    return convlist
  }
}