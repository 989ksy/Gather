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

    struct Input {
        
        let titleText: String //채팅방 제목
        let chatText: ControlProperty<String>
//        let chatPlaceholderText: ControlProperty<String>
        
        let backTap: ControlEvent<Void>
        let sendTap: ControlEvent<Void>
        
        
    }
    
    struct Output {
        
        /*
         
         1. 텍스트필드 활성화 되면 플레이스홀더 없애
         2. 1글자 이상일 경우 send버튼 활성화 + UI
         3. send버튼 tap시 네트워크 통신
         
         */
        
//        let sendValidation: BehaviorSubject<Bool>
        
        let backTapped: BehaviorRelay<Bool>
//        let sendTapped: BehaviorRelay<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        //채팅 플레이스홀더 text
        let placeholderText = BehaviorSubject(value: "메세지를 입력하세요")
        
        //채팅 텍스트가 1글자 이상
        let sendValidation = input.chatText.map {
            $0.count > 0
        }
        
        //뒤로가기 버튼
        let backTapped = BehaviorRelay(value: false)
        
        input.backTap
            .subscribe(with: self) { owner, _ in
                
                backTapped.accept(true)
                
            }
            .disposed(by: disposeBag)
        
        return Output(
//            sendValidation: <#BehaviorSubject<Bool>#>,
            backTapped: backTapped)
    }
    
    
}
