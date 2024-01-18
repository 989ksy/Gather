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
    
    struct Input {
        let nameText: ControlProperty<String>
        let descriptionText: ControlProperty<String>
//        var imageData: BehaviorSubject<Data>
        
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
        
        let nameValidation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        //MARK: - 조건
        
        //제목 1~30자
        let nameValidation = input.nameText.map {
            $0.count > 0 && $0.count < 31
        }
        
        
        //MARK: - 완료버튼
        
        let completeTapped = BehaviorSubject(value: false)
        
        input.completeTap
            .subscribe(with: self) { owner, _ in
                completeTapped.onNext(true)
            }
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
            
            nameValidation: nameValidation)
    }
    
}
