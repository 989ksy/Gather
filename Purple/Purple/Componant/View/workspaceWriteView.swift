//
//  workspaceWriteView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/16/24.
//

import UIKit
import SnapKit

class WorkspaceWriteView: UIView {
    
    let profileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor.brandPurple
        return view
    }()
    
    let profileIconView = {
        let view = UIImageView()
        view.image = ConstantIcon.workspace
        return view
    }()
    
    let cameraButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.cameraCustom, for: .normal)
        return btn
    }()
    
    let workspaceNameLabel = {
        let label = commonTitleLabel()
        label.text = "워크스페이스 이름"
        return label
    }()
    
    let workspaceNameTextfield = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.workspaceName.rawValue
        return field
    }()
    
    let workspaceDescriptionLabel = {
        let label = commonTitleLabel()
        label.text = "워크스페이스 설명"
        return label
    }()
    
    let workspaceDescriptionTextfield = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.workspaceDescription.rawValue
        return field
    }()
    
    let completeButton = {
        let btn = NextButton()
        btn.setTitle("완료", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundPrimary
        
        configureHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureHierarchy() {
        addSubview(profileImageView)
        profileImageView.addSubview(profileIconView)
        addSubview(cameraButton)
        addSubview(workspaceNameLabel)
        addSubview(workspaceNameTextfield)
        addSubview(workspaceDescriptionLabel)
        addSubview(workspaceDescriptionTextfield)
        addSubview(completeButton)
    }
    
    func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        profileIconView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(48)
            make.top.equalToSuperview().offset(10)
            make.horizontalEdges.equalToSuperview().inset(11)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(profileImageView.snp.top).offset(51)
            make.centerX.equalTo(profileImageView.snp.trailing).inset(4)
        }
        
        workspaceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        
        workspaceNameTextfield.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        
        workspaceDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameTextfield.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        
        workspaceDescriptionTextfield.snp.makeConstraints { make in
            make.top.equalTo(workspaceDescriptionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(workspaceDescriptionTextfield.snp.bottom).offset(58)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
    }
    
    
}
