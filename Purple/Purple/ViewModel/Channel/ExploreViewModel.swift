//
//  ExploreViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class ExploreViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    var exploreChannelContainer: BehaviorSubject<[readChannelResponse]> = BehaviorSubject(value: [])
    
    var channelList: [readChannelResponse] = []
    
    
    struct Input {
        
        let workspaceID: Int
        let closeTap: ControlEvent<Void>
        
    }
    
    struct Output {
        
        let closeButtonTapped: BehaviorSubject<Bool>
        
    }
    
    func transform(input: Input) -> Output {
        
        let closeButtonTapped = BehaviorSubject(value: false)
        
        input.closeTap
            .subscribe(with: self) { owner, value in
                
                closeButtonTapped.onNext(true)
                
            }
            .disposed(by: disposeBag)
        
        
        //전체 채널 조회
        Network.shared.requestSingle(
            type: [readChannelResponse].self,
            router: .readAllChannels(
                workspaceID: input.workspaceID
            )
        )
        .subscribe(with: self) { owner, response in
            
            switch response {
                
            case .success(let response):
                
                print("----- 전체 채널 조회 성공🍀", response)
                
                self.exploreChannelContainer.onNext(response)
                
                self.channelList = response
                
            case .failure(let error):
                print("-----😈전체 채널 조회 실패", error)
            }
        }
        .disposed(by: disposeBag)
        
        
        
        
        
        return Output(
            closeButtonTapped: closeButtonTapped
        )
        
    }
    
    
}
