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
    
    var workspaceId = 1 //워크스페이스 아이디
    var chatRoomTitle = "i" //채팅방 제목

    struct Input {
        
        let chatText: ControlProperty<String> //채팅내용
        
        let backTap: ControlEvent<Void>
        let sendTap: ControlEvent<Void>
        
        
    }
    
    struct Output {
        
        /*
         
         1. 텍스트필드 활성화 되면 플레이스홀더 없애
         2. 1글자 이상일 경우 send버튼 활성화 + UI
         3. send버튼 tap시 네트워크 통신
         
         */
        
        let sendValidation: BehaviorSubject<Bool>
        let backTapped: BehaviorRelay<Bool>
//        let sendTapped: BehaviorRelay<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        //채팅 텍스트가 1글자 이상
        //텍스트버튼 활성화
        let textValidation = input.chatText.map {
            $0.count > 0
            
        }
        
        let sendValidation = BehaviorSubject(value: false)
        
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
                    
                case .failure(let error):
                    
                    print("--- 😈 채널 채팅 보내기 실패:", error)
                    print(error.localizedDescription)
                }
                
            }
            .disposed(by: disposeBag)
        
        
        
        
        return Output(
            sendValidation: sendValidation,
            backTapped: backTapped
        )
    }
    
    
}
