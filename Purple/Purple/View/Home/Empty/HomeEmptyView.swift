//
//  HomeEmptyView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit
import SnapKit

class HomeEmptyView: BaseView {
    
    let navigaitonBarItemView = {
        let view = WorkspaceNavigationBarView()
        return view
    }()
    
    
    let titleLabel = {
        let label = TitleLabel()
        label.text = "워크스페이스를 찾을 수 없어요."
        label.textAlignment = .center
        return label
    }()
    
    let subLabel = {
        let label = SubTitleLabel()
        label.text = "관리자에게 초대를 요청하거나, 다른 이메일로 시도하거나\n새로운 워크스페이스를 생성해주세요."
        return label
    }()
    
    let emptyImage: UIImageView = {
        let view = UIImageView()
        view.image = ConstantImage.empty.image
        return view
    }()
    
    let nextButton: UIButton = {
        let btn = NextButton()
        btn.setTitle("워크스페이스 생성", for: .normal)
        return btn
    }()
    
    
    override func configureView() {
        addSubview(navigaitonBarItemView)
        addSubview(titleLabel)
        addSubview(subLabel)
        addSubview(emptyImage)
        addSubview(nextButton)
        
        nextButton.backgroundColor = .brandPurple
    }
    
    override func setConstraints() {
        
        navigaitonBarItemView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
            make.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigaitonBarItemView.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.width.equalTo(345)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        emptyImage.snp.makeConstraints { make in
            make.size.equalTo(368)
            make.top.equalTo(subLabel.snp.bottom).offset(15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(345)
        }
        
    }
    
    
}
