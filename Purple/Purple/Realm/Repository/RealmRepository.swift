//
//  RealmRepository.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/14/24.
//

import Foundation
import RealmSwift

protocol RealmRepositoryType: AnyObject { }

final class RealmRepository: RealmRepositoryType {
    
    private var realm = try! Realm()
    
    private var tasks: Results<ChatDataTable>!
    
    //MARK: - 파일경로; Realm 테이블 확인
    
    func checkFileURL() {
        print(realm.configuration.fileURL!)
    }
    
    //MARK: - 채팅 불러오기
    
    //채팅 저장 데이터?
    func fetchChatData(channelID: Int) -> Results<ChatDataTable> {
        
        let data = realm.objects(ChatDataTable.self)
            .where  { $0.channelData.channelId == channelID }
        
        return data
        
    }
    
    //가장 최근 채팅 날짜 구하기
    func fetchLatestChatData(channelID: Int) -> Date? {
        
        let data = realm.objects(ChatDataTable.self)
            .where  { $0.channelData.channelId == channelID }
            .sorted(byKeyPath: "createdAt", ascending: false)
            .first?
            .createdAt
        
        return data
    }
    
    
    //MARK: - 채팅저장
    
    func addChattingData(_ item: ChatDataTable) {
        
        let itemUserID = item.userData!.user_id
        let itemChannelID = item.channelData!.channelId
        
        
        do {
            try realm.write {
                
                // 1. 채널 분기처리
                
                if let existChannel = realm.objects(ChannelDataTable.self)
                    .filter("channelId == %@", itemChannelID).first {
                    
                } else {
                    let newChannel = item.channelData
                    realm.add(newChannel!)
                }
                
                
                // 2. 유저 분기처리
                
                if let existedUser = realm.objects(UserDataTable.self).filter("user_id == %@", itemUserID).first {
                    
                } else {
                    let newUser = item.userData
                    realm.add(newUser!)
                }
                
                
                // 3. item의 userData, channelData 다시 넣어주기
                
                item.channelData = realm.objects(ChannelDataTable.self).filter("channelId == %@", itemChannelID).first!
                item.userData = realm.objects(UserDataTable.self).filter("user_id == %@", itemUserID).first!
                
                realm.add(item)
                
                print("---- ✅ addChattingData 성공")
                
            }
        } catch {
            print("---- 😈 addChattingData 실패")
        }
        
    }

    
}
