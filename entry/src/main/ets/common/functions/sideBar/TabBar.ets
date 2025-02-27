import {RandomUtil} from  '@pura/harmony-utils'
import {ConversationBasicInfo} from "../../entities/ConversationBasicInfo"
export function createNewTabInfo():ConversationBasicInfo{
  let newInfo : ConversationBasicInfo = {id:RandomUtil.generateUUID32(),title:"New Conversation",createdAt:Date.now().toString(),updatedAt:Date.now().toString()}
  return newInfo
}

export function deleteSelectTab() {

}