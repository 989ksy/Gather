//
//  SignupView.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit
import SnapKit

class SignupView: BaseView {
    
    let emptyView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //닫기버튼
    let closeButton = {
        let btn = CloseButton()
        return btn
    }()
    
    //회원가입 레이블
    let titleLabel = {
        let label = NavigationTitleLabel()
        label.text = "회원가입"
        return label
    }()
    
    //Divider
    let divider = {
        let view = Divider()
        return view
    }()
    
    //이메일
    let emailTitleLabel = {
        let label = commonTitleLabel()
        label.text = "이메일"
        return label
    }()
    
    let emailTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.email.rawValue
        return field
    }()
    
    let validationCheckButton = {
        let btn = NextButton()
        btn.setTitle("중복 확인", for: .normal)
        return btn
    }()
    
    //닉네임
    let nickTitleLabel = {
        let label = commonTitleLabel()
        label.text = "닉네임"
        return label
    }()
    
    let nickTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.nick.rawValue
        return field
    }()
    
    //연락처
    let contactTitleLabel = {
        let label = commonTitleLabel()
        label.text = "연락처"
        return label
    }()
    
    let contactTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.phoneNum.rawValue
        field.keyboardType = .numberPad
        return field
    }()
    
    //비밀번호
    let passwordTitleLabel = {
        let label = commonTitleLabel()
        label.text = "비밀번호"
        return label
    }()
    
    let passwordTextField = {
        let field = commonTextField()
        field.isSecureTextEntry = true
        field.placeholder = PlaceholderText.password.rawValue
        return field
    }()
    
    //비밀번호확인
    let passwordValidationTitleLabel = {
        let label = commonTitleLabel()
        label.text = "비밀번호 확인"
        return label
    }()
    
    let passwordValidationTextField = {
        let field = commonTextField()
        field.isSecureTextEntry = true
        field.placeholder = PlaceholderText.checkPassword.rawValue
        return field
    }()
    
    //가입하기 버튼
    
    let signUpButton = {
        let btn = NextButton()
        btn.setTitle("가입하기", for: .normal)
        return btn
    }()
    
    
    
    override func configureView() {
        
        addSubview(emptyView)
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(divider)
        
        addSubview(emailTitleLabel)
        addSubview(emailTextField)
        addSubview(validationCheckButton)
        
        addSubview(nickTitleLabel)
        addSubview(nickTextField)
        
        addSubview(contactTitleLabel)
        addSubview(contactTextField)
        
        addSubview(passwordTitleLabel)
        addSubview(passwordTextField)
        
        addSubview(passwordValidationTitleLabel)
        addSubview(passwordValidationTextField)
        
        addSubview(signUpButton)
        
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(divider)
        }
        
        //MARK: - 최상단
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
        }
        
        //MARK: - 중간
        
        //이메일
        emailTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(divider).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(44)
            make.width.equalTo(233)
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(8)
        }
        
        validationCheckButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.leading.equalTo(emailTextField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(emailTextField)
        }
        
        //닉네임
        nickTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        nickTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(nickTitleLabel.snp.bottom).offset(8)
        }
        
        //연락처
        contactTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(nickTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        contactTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(contactTitleLabel.snp.bottom).offset(8)
        }
        
        //비밀번호
        passwordTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(contactTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
        }
        
        //비밀번호 확인
        passwordValidationTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(passwordTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        passwordValidationTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(passwordValidationTitleLabel.snp.bottom).offset(8)
        }
        
        //가입하기
        signUpButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(45)
        }
        
    }
    
    
}
