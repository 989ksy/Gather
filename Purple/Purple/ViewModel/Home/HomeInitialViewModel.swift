//
//  HomeInitialViewModel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeInitialViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
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
