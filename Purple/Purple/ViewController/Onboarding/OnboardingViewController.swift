//
//  OnboardingViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController, UISheetPresentationControllerDelegate {
    
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
                let vc = AuthViewController()
                vc.modalPresentationStyle = .pageSheet
                
                let customDetentId = UISheetPresentationController.Detent.Identifier("custom")
                let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentId) { context in
                    return 279
                }
                self.sheetPresentationController?.detents = [customDetent]
                
                if let sheet = vc.sheetPresentationController {
                    //지원할 크기 지정
                    sheet.detents = [customDetent]
                    //크기 변하는거 감지
                    sheet.delegate = self
                    sheet.prefersGrabberVisible = true
                }
                
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
