//
//  OnboardingViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController {
    
    let mainView = OnboardingView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    override func configureView() {
        view.backgroundColor = ConstantColor.bgPrimary
    }
    
    func bind() {
        
        mainView.startButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                
                self.transitionCustomSheetVC(AuthViewController())
                
            }
            .disposed(by: disposeBag)
    }
    
    
}
