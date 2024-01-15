//
//  EmailLoginView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/14/24.
//

import UIKit
import SnapKit


class EmailLoginView: BaseView {
    
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
    
    //이메일 로그인 레이블
    let titleLabel = {
        let label = NavigationTitleLabel()
        label.text = "이메일 로그인"
        return label
    }()
    
    //Divider
    let divider = {
        let view = Divider()
        return view
    }()
    
    //이메일
    let emailTitleLabel = {
        let label = SignupTitleLabel()
        label.text = "이메일"
        return label
    }()
    
    let emailTextField = {
        let field = SignupTextField()
        field.placeholder = PlaceholderText.email.rawValue
        return field
    }()
    
    //닉네임
    let passwordTitleLabel = {
        let label = SignupTitleLabel()
        label.text = "비밀번호"
        return label
    }()
    
    let passwordTextField = {
        let field = SignupTextField()
        field.placeholder = PlaceholderText.nick.rawValue
        return field
    }()
    

    //로그인 버튼
    let logInButton = {
        let btn = NextButton()
        btn.setTitle("로그인하기", for: .normal)
        return btn
    }()
    
    
    
    override func configureView() {
        
        addSubview(emptyView)
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(divider)
        
        addSubview(emailTitleLabel)
        addSubview(emailTextField)
        
        addSubview(passwordTitleLabel)
        addSubview(passwordTextField)
        
        addSubview(logInButton)
        
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(divider)
        }
        
        //MARK: - 최상단 (네비게이션바 부분)
        
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
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(8)
        }
        
        //비밀번호
        passwordTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(8)
        }
     
        
        //가입하기
        logInButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(45)
        }
        
    }
    
    
    
    
}
