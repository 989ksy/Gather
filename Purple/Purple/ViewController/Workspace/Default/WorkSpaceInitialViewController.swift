//
//  WorkSpaceInitialViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/8/24.
//

import UIKit

import RxSwift
import RxCocoa

final class WorkSpaceInitialViewController: BaseViewController {
    
    let mainView = WorkSpaceInitialView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = ConstantColor.bgPrimary
        mainView.nextButton.backgroundColor = .brandPurple
    }
    
    
    func bind() {
        
        //MARK: - closeButton
        
        let closeButtonTapped = BehaviorSubject(value: false) //닫기 버튼 누름
        
        mainView.closeButton.rx.tap
            .subscribe(with: self) { owner, _ in
                closeButtonTapped.onNext(true)
            }
            .disposed(by: disposeBag)
        
        closeButtonTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.dismiss(animated: true)
                    
                    let vc = HomeEmptyViewController()
                    self.view.window?.rootViewController = vc
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
