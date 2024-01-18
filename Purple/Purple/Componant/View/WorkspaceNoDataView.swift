//
//  WorkspaceNoDataView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/18/24.
//

import UIKit
import SnapKit

final class WorkspaceNoDataView: UIView {
    
    let titleLabel = {
        let label = TitleLabel()
        label.text = "워크스페이스를\n찾을 수 없어요."
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 5)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel = {
        let label = SubTitleLabel()
        label.text = "관리자에게 초대를 요청하거나,\n다른 이메일로 시도하거나\n 새로운 워크스페이스를 생성해주세요."
        label.setLineSpacing(spacing: 5)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let createButton = {
        let btn = NextButton()
        btn.setTitle("워크스페이스 생성", for: .normal)
        btn.backgroundColor = UIColor.brandPurple
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(titleLabel)
        addSubview(subLabel)
        addSubview(createButton)
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(75)
        }
        
        createButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(subLabel.snp.bottom).offset(19)
        }
        
        
    }
    
}
