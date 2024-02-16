//
//  ChannelChattingViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ChannelChattingViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    //Realm
    let repository = RealmRepository()
    
    var workspaceId = 1 //워크스페이스 아이디
    var chatRoomTitle = "i" //채팅방 제목
    var channelId = 1 //채널 아이디
    
    //채팅데이터 불러오기 담음
    var readChatData: [CreateChannelChatResponse] = []
    
    //새 채팅데이터 담음
    let updatedCahtData = PublishSubject<CreateChannelChatResponse>()
    
    //가장 최근 날짜의 채팅을 이용해서
    //읽지 않은 메세지 채팅창 입장 시 즉시 렘 저장 -> 이전 + 뉴 대화 로드 가능
    func fetchChatData() {
        
        //가장 최근 날짜의 채팅 날짜
        let date = self.repository.fetchLatestChatData(channelID: self.channelId) ?? Date()
        
        //가장 최근 채팅 날짜의 시간에 + 9 -> 스트링으로 변경
        let newDate = addNineHours(to: date)
        let stringDate = newDate.toString(of: .toAPI)
        
        Network.shared.request(
            type: [CreateChannelChatResponse].self,
            router: .readChannelCahtting(
                channelNm: chatRoomTitle,
                workspaceID: workspaceId,
                cursorDate: stringDate
            )) { response in
                
                switch response {
                    
                case .success(let data):
                    
                    self.readChatData = data
                    print("--- ✅ 채팅 데이터 읽어오기 성공:", data)
                    
                    //DB 저장 (아직 읽지 않은 데이터였을 경우)
                    DispatchQueue.main.async {
                        
                        data.forEach { item in
                            
                            AddChatDataToRealm(item, workspaceID: self.workspaceId, title: self.chatRoomTitle, date: item.createdAt.toDate(to: .fromAPI)!)
                            
                        }
                        
                    }

                                        
                case .failure(let error):
                    print("--- 😈 채팅 데이터 읽어오기 실패:", error)
                }
                
            }
        
    }

    struct Input {
        
        let chatText: ControlProperty<String> //채팅내용
        
        let backTap: ControlEvent<Void>
        let sendTap: ControlEvent<Void>
        
        
    }
    
    struct Output {
        
        let sendValidation: BehaviorSubject<Bool>
        let backTapped: BehaviorRelay<Bool>
        let messageIsSent: BehaviorRelay<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        //채팅 텍스트가 1글자 이상
        //텍스트버튼 활성화
        let textValidation = input.chatText.map {
            $0.count > 0
            
        }
        
        //보내기 버튼 활성화
        let sendValidation = BehaviorSubject(value: false)
        
        //메세지 전송 후 작성내용 초기화
        let messageIsSent = BehaviorRelay(value: false)
        
        textValidation
            .subscribe(with: self) { owner, value in
                
                if value {
                    sendValidation.onNext(true)
                }
                
            }
            .disposed(by: disposeBag)
        
        
        //뒤로가기 버튼
        let backTapped = BehaviorRelay(value: false)
        
        input.backTap
            .subscribe(with: self) { owner, _ in
                
                backTapped.accept(true)
                
            }
            .disposed(by: disposeBag)
        
        //채팅전송
        input.sendTap
            .throttle(
                .seconds(3),
                scheduler: MainScheduler.instance
            )
            .withLatestFrom(input.chatText)
            .flatMap { chatText in
                Network.shared.requestMultipart(
                    type: CreateChannelChatResponse.self,
                    router: .createChannelChatting(
                        channelNm: self.chatRoomTitle,
                        workspaceID: self.workspaceId,
                        model: createChannelChatInput(
                            content: chatText,
                            files: nil
                        )
                    )
                )
            }
            .subscribe(with: self) { owner, response in
                
                switch response {
                    
                case .success(let result):
                    
                    print("--- ✅ 채널 채팅 보내기 성공", result)
                    
                    //메세지 보내짐 확인용: 내용 초기화함
                    messageIsSent.accept(true)
                    
                    //날짜(string -> Date) 변환
                    let dateString = result.createdAt
                    var date: Date?
                    
                    if let convertedDate = dateString.toDate(to: .fromAPI) {
                        print("--- date 변환 성공:", convertedDate)
                        date = convertedDate
                    } else {
                        print("날짜 변환 실패")
                    }
                    
                    //Realm에 저장
                    AddChatDataToRealm(result, workspaceID: self.workspaceId, title: self.chatRoomTitle, date: date!)
                    
                    //채팅창에 새 메세지 업로드
                    DispatchQueue.main.async {
                        
                        self.updatedCahtData.onNext(result)
                        
                    }
                    
                    
                case .failure(let error):
                    
                    print("--- 😈 채널 채팅 보내기 실패:", error)
                }
                
            }
            .disposed(by: disposeBag)
        
        
        
        
        return Output(
            sendValidation: sendValidation,
            backTapped: backTapped,
            messageIsSent: messageIsSent
        )
    }
    
    
}

