//
//  InviteMemberViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/5/24.
//

import UIKit
import SnapKit

final class InviteMemberViewController: BaseViewController {
    
    //MARK: - UI
    
    //커스텀네비게이션바 영역
    let customNavigationbarView = {
        let view = CustomPresentNavigationBarView()
        view.navigationTitleLable.text = "팀원 초대"
        view.backgroundColor = ConstantColor.bgSecondary
        return view
    }()
    
    //이메일
    let emailLabel = {
        let label = commonTitleLabel()
        label.text = "이메일"
        return label
    }()
    
    let emailTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.inviteMember.rawValue
        return field
    }()
    

    //로그인 버튼
    let inviteButton = {
        let btn = NextButton()
        btn.setTitle("초대 보내기", for: .normal)
        return btn
    }()

    
    //MARK: - 로직
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - UI 레이아웃
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(customNavigationbarView)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(inviteButton)
        
    }
    override func setConstraints() {
        
        customNavigationbarView.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(customNavigationbarView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
        }
        
        inviteButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(45)
        }
        
    }
    
    
}
