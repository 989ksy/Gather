//
//  AuthView.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit
import SnapKit

class AuthView: BaseView {
    
    let appleLoginButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.appleButton, for: .normal)
        return btn
    }()
    
    let kakaoLoginButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.kakaoButton, for: .normal)
        return btn
    }()
    
    let emailLoginButton = {
        var configuration = UIButton.Configuration.filled()
        
        //버튼 폰트 설정
        var titleContainer = AttributeContainer()
        titleContainer.font = ConstantTypo.title2
        var subtitleContainer = AttributeContainer()
        subtitleContainer.foregroundColor = UIColor.white

        // 버튼 Contents 커스텀
        configuration.attributedTitle = AttributedString("이메일로 계속하기", attributes: titleContainer)
        configuration.image = ConstantIcon.emailCustom
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = ConstantColor.purpleBrand

        // 이미지가 왼쪽에 위치한 버튼
        configuration.titleAlignment = .leading
        let btn = UIButton(configuration: configuration)
        return btn
    }()
    
    let stackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.spacing = 2
        return view
    }()
    
    let signUpLabel = {
        let label = UILabel()
        label.font = ConstantTypo.title2
        label.textColor = ConstantColor.blackBrand
        label.text = "또는"
        return label
    }()
    
    let signUpButton = {
        let btn = UIButton()
        btn.setTitle("새롭게 회원가입 하기", for: .normal)
        btn.setTitleColor(ConstantColor.purpleBrand, for: .normal)
        btn.titleLabel?.font = ConstantTypo.title2
        return btn
    }()
    
    override func configureView() {
        
        addSubview(appleLoginButton)
        addSubview(kakaoLoginButton)
        addSubview(emailLoginButton)
        addSubview(stackView)
        stackView.addArrangedSubview(signUpLabel)
        stackView.addArrangedSubview(signUpButton)
        
    }
    
    override func setConstraints() {
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(44)
            make.width.equalTo(324)
            make.centerX.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(16)
            make.height.equalTo(44)
            make.width.equalTo(324)
            make.centerX.equalToSuperview()
        }
        
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(16)
            make.height.equalTo(44)
            make.width.equalTo(324)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(emailLoginButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(123)
        }
    }
    
}
