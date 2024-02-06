//
//  HomeEmptyViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit

import RxSwift
import RxCocoa

class HomeEmptyViewController: BaseViewController {
    
    let mainView = HomeEmptyView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        
        //생성하기 버튼 클릭
        let isNextButtonTapped = PublishSubject<Bool>()
        
        mainView.nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                isNextButtonTapped.onNext(true)
            }
            .disposed(by: disposeBag)
        
        isNextButtonTapped
            .bind(to: mainView.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        isNextButtonTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.transitionLargeSheetVC(WorkspaceAddViewController())
                    
                }
                
            }
            .disposed(by: disposeBag)
            
        
        
    }
    
    
}
