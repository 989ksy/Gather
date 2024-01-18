//
//  HomeEmptyViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit

import RxSwift
import RxCocoa

class HomeEmptyViewController: BaseViewController, UISheetPresentationControllerDelegate {
    
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
                    
                    let vc = WorkspaceAddViewController()
                    vc.modalPresentationStyle = .pageSheet
                    
                    if let sheet = vc.sheetPresentationController {
                        sheet.detents = [.large()]
                        sheet.delegate = self
                        sheet.prefersGrabberVisible = true
                    }
                    
                    self.present(vc, animated: true, completion: nil)
                    
                }
                
            }
            .disposed(by: disposeBag)
            
        
        
    }
    
    
}
