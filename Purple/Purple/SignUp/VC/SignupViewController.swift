//
//  SignupViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SignupViewController: BaseViewController {
    
    let mainView = SignupView()
    let viewModel = SignupViewModel()
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
    }
    
    func bindVM() {
        
        let input = SignupViewModel.Input(
            closeButtonTap:
                mainView.closeButton.rx.tap,
            emailText:
                mainView.emailTextField.rx.text.orEmpty,
            emailValidationTap:
                mainView.validationCheckButton.rx.tap,
            nickText:
                mainView.nickTextField.rx.text.orEmpty,
            phoneNumbText:
                mainView.contactTextField.rx.text.orEmpty,
            passwordText:
                mainView.passwordTextField.rx.text.orEmpty,
            passwordValidText:
                mainView.passwordValidationTextField.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        //닫기버튼 탭했을 때
        input.closeButtonTap
            .subscribe(with: self) { owner, _ in
                //Auth 화면으로 전환
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        //이메일
        output.emailValidation
            .bind(to: mainView.validationCheckButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //이메일 정규식 반응_ 중복확인버튼 활성화
        output.emailValidation
            .subscribe(with: self) { owner, bool in
                owner.mainView.validationCheckButton.backgroundColor = bool ? ConstantColor.purpleBrand : ConstantColor.inActiveBrand
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    
    
}
