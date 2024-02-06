//
//  CreateChannelViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class CreateChannelViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        
        let workspaceID: Int
        let channelName: ControlProperty<String>
        let channelDescription: ControlProperty<String>
        let createTap: ControlEvent<Void>
        
    }
    
    struct Output {
        
        let tapValidation: BehaviorSubject<Bool>
        let isCreated: BehaviorSubject<Bool> //워크스페이스로 복귀 + 채널 리스트 업데이트
        let isNameDuplicated: BehaviorRelay<Bool>
        
    }
    
    
    func transform(input: Input) -> Output {
        
        //이름값 필수
        let isNameValid = input.channelName.map { !$0.isEmpty }
        
        //버튼 활성화여부
        let tapValidation = BehaviorSubject(value: false)
        
        isNameValid
            .bind(to: tapValidation)
            .disposed(by: disposeBag)
        
        let createValues = Observable.combineLatest(input.channelName, input.channelDescription).map { input in
            return input
        }
        
        //생성됨?
        let isCreated = BehaviorSubject(value: false)
        
        //이름중복이냐?
        let isNameDublicated = BehaviorRelay(value: false)
        
        //생성하기 버튼 -> 네트워크 전송 + 화면전환 준비
        input.createTap
            .throttle(
                .seconds(2),
                latest: false,
                scheduler: MainScheduler.instance
            )
            .withLatestFrom(createValues)
            .flatMap { userInput in
                Network.shared.requestSingle(
                    type: readChannelResponse.self,
                    router: .createChannels(
                        workspaceID: input.workspaceID,
                        model: .init(
                            name: userInput.0,
                            description: userInput.1
                        )
                    )
                )
            }
            .subscribe(with: self) { owner, response in
                
                switch response {
                    
                case .success(let response):
                    print("-----✅ 채널생성 성공:", response)
                    
                    isCreated.onNext(true)
                    
                case .failure(let error):
                    
                    isNameDublicated.accept(true)
                    print("-----😈 채널생성 실패:", error)
                    
                }
                
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(
            tapValidation: tapValidation,
            isCreated: isCreated,
            isNameDuplicated: isNameDublicated
        )
        
    }
    
    
    
}
