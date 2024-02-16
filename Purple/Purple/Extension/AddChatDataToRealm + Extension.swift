//
//  AddChatDataToRealm + Extension.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/15/24.
//

import Foundation

let repository = RealmRepository()

//렘에 채팅 데이터 저장 메서드
func AddChatDataToRealm(_ item: CreateChannelChatResponse, workspaceID: Int, title: String, date: Date) {
    
    repository.addChattingData (
    ChatDataTable(
        chatId: item.chatID,
        userData: UserDataTable(
            user_id: item.user.userID,
            userName: item.user.nickname,
            userEmail: item.user.email,
            userImage: item.user.profileImage
        ),
        channelData: ChannelDataTable(
            channelID: item.channelID,
            workspaceID: workspaceID,
            channelName: title
        ),
        content: item.content,
        createdAt: date
    )
    )
    
    
    
}
