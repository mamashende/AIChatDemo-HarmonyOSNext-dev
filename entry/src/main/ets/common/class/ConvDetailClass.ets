import {Conversation} from "../entities/Conversation"
import {Message} from "../entities/Message"
import {Role} from "../entities/Role"
import {KvUtil} from '@pura/harmony-utils'


const MONITOR_PREFIX = "__ob_"
const USER_KEY_ConvList = "user_key_global_ConvList"

@ObservedV2
export  class ChatMessage implements Message {
  @Trace
  role: Role;
  @Trace
  content: string;

  constructor(role: Role, content: string) {
    this.role = role;
    this.content = content;
  }

  // 你可以在这里添加其他方法或功能
  displayMessage(): void {
    console.log(`[${this.role}] ${this.content}`);
  }
}

@ObservedV2
export class ConvDetail  {
  @Trace
  id: string = '';
  @Trace
  title : string = '';

  @Trace
  messages: ChatMessage[] = [];
  @Trace
  createdAt: string = '';
  @Trace
  updatedAt: string = '';



  @Monitor("messages","updatedAt")notifyAttributeChanged(monitor: IMonitor) {
    let value = JSON.stringify(this).replaceAll(MONITOR_PREFIX, "")
    console.log("user info: " + value)
    //KVManager.get().put(USER_KEY, value)

    KvUtil.put(this.id,value);



  }
  // 从本地磁盘取出缓存数据
  static async create(key : string): Promise<ConvDetail> {

    let value = await KvUtil.get(key) as  string
    if (value.length < 1) {
      return new ConvDetail()
    }
    let object = JSON.parse(value) as ConvDetail
    let convdetail = new ConvDetail();
    return convdetail
  }

}