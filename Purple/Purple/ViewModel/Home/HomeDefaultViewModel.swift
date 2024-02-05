//
//  HomeDefaultViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation
import RxSwift
import RxCocoa


final class HomeDefaultViewModel: ViewModelType {
    
    let sectionList: [String] = ["채널", "다이렉트 메세지", "팀원추가"]
    var isOpen = [true, true] //섹션 폴딩값
    
    let disposeBag = DisposeBag()
    
    
    //MARK: - 워크스페이스가 1개일 경우
    
    //워크스페이스ID로 통신한 값 담음
    var workspaceIdForOneContainer = BehaviorSubject(
        value: readOneWorkspaceResponse(
            workspaceID: 0,
            name: "",
            description: "",
            thumbnail: "",
            ownerID: 0,
            createdAt: "",
            channels: [],
            workspaceMembers: []
        )
    )
    
    //프로필정보 받음
    var profileForOneContainer = BehaviorSubject(
        value: readMyProfileResponse(
            userID: 0,
            email: "",
            nickname: "",
            profileImage: "",
            phone: "",
            vendor: "",
            sesacCoin: 0,
            createdAt: ""
        )
    )
    
    //채널리스트 받음
    //    var channelListForOneContainer = BehaviorSubject(
    //        value: readMyChannelResponse(
    //            workspaceID: 0,
    //            channelID: 0,
    //            name: "",
    //            description: "",
    //            ownerID: 0,
    //            privateNm: 0,
    //            createdAt: ""
    //        )
    //    )
    
    let channelListForOneContainer = BehaviorSubject<[readMyChannelResponse]>(value: [])
    
    //네비게이션뷰 name 가져옴
    func getTitleForOne(workspaceID: Int) {
        
        Network.shared.requestSingle(
            type: readOneWorkspaceResponse.self,
            router: .readOneWorkSpace(workspaceID: workspaceID)
        )
        .subscribe(with: self) { owner, response in
            
            switch response {
            case .success(let data):
                self.workspaceIdForOneContainer.onNext(data)
                
                print("--------------🏠 워크스페이스 한 개 일 경우:", data)
                
            case .failure(let error):
                print(error)
            }
        }
        .disposed(by: disposeBag)
    }
    
    //프로필 정보 가져옴
    func getProfileForOne() {
        
        Network.shared.requestSingle(
            type: readMyProfileResponse.self,
            router: .readMyProfile
        )
        .subscribe(with: self) { owner, response in
            
            switch response {
                
            case .success(let data):
                self.profileForOneContainer.onNext(data)
                print("---- 내 프로필 정보 조회 성공!")
                
            case .failure(let error):
                print("---- 내 프로필정보 조회 실패:", error)
            }
            
        }
        .disposed(by: disposeBag)
    }
    
    
    func getChannelForOne(workspaceID: Int) {
//        
//        Network.shared.requestSingle(
//            type: [readMyChannelResponse].self,
//            router: .readMyChannels(workspaceID: workspaceID)
//        )
//        .subscribe(with: self) { owner, response in
//            
//            switch response {
//                
//            case .success(let data):
//                
//                owner.channelListForOneContainer.onNext(data)
//                
//                print("---- 내가 속한 모든 채널 조회 성공:", data)
//                
//            case .failure(let error):
//                print("---- 내가 속한 모든 채널 조회 실패:", error)
//            }
//            
//        }
//        .disposed(by: disposeBag)
        
    }
    
    
    
    struct Input {
        let circleTap: ControlEvent<Void>
    }
    
    struct Output {
        let circleTapped: BehaviorSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let circleTapped = BehaviorSubject(value: false)
        
        input.circleTap
            .subscribe(with: self) { owner, _ in
                
                circleTapped.onNext(true)
                
            }
            .disposed(by: disposeBag)
        
        return Output(circleTapped: circleTapped)
    }
    
    
}
