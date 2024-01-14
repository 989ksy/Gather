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
        
        mainView.contactTextField.delegate = self //닉네임 텍스트필드 딜리게이트
        
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
            signupTap:
                mainView.signUpButton.rx.tap,
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
        output.closeButtonTapped
            .subscribe(with: self) { owner, _ in
                //Auth 화면으로 전환
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        //이메일중복버튼 작동연결
        output.emailValidation
            .bind(to: mainView.validationCheckButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //이메일 중복확인버튼 활성화
        output.emailValidation
            .subscribe(with: self) { owner, bool in
                
                owner.mainView.validationCheckButton.backgroundColor = bool ? ConstantColor.purpleBrand : ConstantColor.inActiveBrand
                
            }
            .disposed(by: disposeBag)
        
        //가입하기 버튼연결
        output.isValidForSignup
            .bind(to: mainView.signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isValidForSignup
            .subscribe(with: self) { owner, bool in
  
                owner.mainView.signUpButton.backgroundColor = bool ? ConstantColor.purpleBrand : ConstantColor.inActiveBrand
            }
            .disposed(by: disposeBag)
        
        output.signUpButtonTapped
            .bind(to: mainView.signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.signUpButtonTapped
            .subscribe(with: self) { owner, bool in
                let vc = WorkSpaceInitialViewController()
                self.view.window?.rootViewController = vc
            }
            .disposed(by: disposeBag)
        
    }
    
    
}


extension SignupViewController: UITextFieldDelegate {
    
    //전화번호
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            let validText = updatedText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            if let formattedNumber = formatPhoneNumber(validText) {
                textField.text = formattedNumber
                return false
            }
        }
        return true
    }

    func formatPhoneNumber(_ phoneNumber: String) -> String? {
       
        guard phoneNumber.count <= 11 && phoneNumber.hasPrefix("01") else {
            return nil
        }
        
        var formattedNumber = ""

        for (index, char) in phoneNumber.enumerated() {
            if index == 3 || index == 7 {
                formattedNumber += "-"
            }
            formattedNumber += String(char)
        }
        
        return formattedNumber
    }
    
    
}
