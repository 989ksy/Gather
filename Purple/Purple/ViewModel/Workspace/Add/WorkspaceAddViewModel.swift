//
//  WorkspaceAddViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WorkspaceAddViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    //썸네일 저장
    let imageInput = PublishRelay<Data>.init()
    
    struct Input {
        
        //입력값
        let nameText: ControlProperty<String>
        let descriptionText: ControlProperty<String>
        let thumImageInput: Observable<Data>
        
        //Tap
        let cameraTap: ControlEvent<Void>
        let completeTap: ControlEvent<Void>
        let closeTap: ControlEvent<Void>
        
    }
    
    struct Output {
        
        //버튼
        let cameraTapped: BehaviorSubject<Bool>
        let completeTapped: BehaviorSubject<Bool>
        let closeTapped: BehaviorSubject<Bool>
        
        //필수값
        let buttonColorValidation: Observable<Bool>
    }
    
    
//    private func createWorkspace(
//        name: String,
//        description: String,
//        image: Data
//    ) -> Observable<createWorkSpaceResponse> {
//        
//        return Network.shared.requestMultipart(
//            type: createWorkSpaceResponse.self,
//            router: .createWorkSpace(
//                model: createWorkSpaceInput(
//                    name: name,
//                    description: description,
//                    image: image
//                )
//            )
//        )
//        .asObservable()
//        .flatMap { result in
//            
//            switch result {
//            case .success(let response):
//                return Observable.just(response)
//            case .failure(let error):
//                return Observable.error(error)
//            }
//            
//        }
//    }
    
    func transform(input: Input) -> Output {
        
        //MARK: - 조건
        
        //제목: 1~30자, 사진 O
        
        let nextColorValidation = Observable.combineLatest(input.nameText, input.thumImageInput) { text, image in
            
            return text.count > 0 && text.count < 31 && !image.isEmpty
        }
        
        
        //MARK: - 완료버튼; 네트워크 보냄
        
        //조건 다 챙기면 액션
        let completeTapped = BehaviorSubject(value: false)
        
        //제목
        let titleText = input.nameText
            .map { text -> String in
                return String(text)
            }
        
        //설명
        let descriptionText = input.descriptionText
            .map { text -> String in
                return String(text)
            }
        
        //제목 + 설명 + 사진
        let value = Observable.combineLatest(
            titleText,
            descriptionText,
            input.thumImageInput
        )
        
        input.completeTap
            .throttle(
                .seconds(1),
                scheduler: MainScheduler.instance
            )
            .withLatestFrom(value)
            .flatMap { value in
                
                Network.shared.requestMultipart(
                    
                    type: createWorkSpaceResponse.self,
                    router: .createWorkSpace(
                        
                        model: createWorkSpaceInput(
                            name: value.0,
                            description: value.1,
                            image: value.2
                            
                        )
                    )
                )
            }
            .subscribe(with: self, onNext: { owner, response in
                
                switch response {
                    
                case .success(let data):
                    completeTapped.onNext(true)
                    
                    print("---- ✅ 워크스페이스 생성 network 통신 성공")

                case .failure(_):
                    completeTapped.onNext(false)
                    
                    print("---- 😈 워크스페이스 생성 network 통신 실패")

                }
                
            })
            .disposed(by: disposeBag)
        
        
        //MARK: - 카메라버튼
        
        let cameraTapped = BehaviorSubject(value: false)
        
        input.cameraTap
            .subscribe(with: self) { owner, _ in
                cameraTapped.onNext(true)
            }
            .disposed(by: disposeBag)
        
        //MARK: - 닫기버튼
        
        let closeTapped = BehaviorSubject(value: false)
        
        input.closeTap
            .subscribe(with: self) { owner, _ in
                closeTapped.onNext(true)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            cameraTapped: cameraTapped,
            completeTapped: completeTapped,
            closeTapped: closeTapped,
            
            buttonColorValidation: nextColorValidation
        )
    }
    
}
