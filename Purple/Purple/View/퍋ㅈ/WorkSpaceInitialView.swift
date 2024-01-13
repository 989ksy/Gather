//
//  WorkSpaceInitialView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/9/24.
//

import UIKit
import SnapKit

final class WorkSpaceInitialView: BaseView {
    
    let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let closeButton: UIButton = {
        let btn = CloseButton()
        return btn
    }()
    
    let titleLabel: UILabel = {
        let label = NavigationTitleLabel()
        label.text = "시작하기"
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        return view
    }()
    
    let mainLabel: UILabel = {
        let label = TitleLabel()
        label.text = "출시 준비 완료!"
        return label
    }()
    
    let subLabel: UILabel = {
        let label = SubTitleLabel()
        label.text = "옹골찬 고래밥님의 조직을 위해 새로운 새싹톡 워크스페이스를\n시작할 준비가 완료되었어요!"
        return label
    }()
    
    let initialImage: UIImageView = {
        let view = UIImageView()
        view.image = ConstantImage.launchingImage
        return view
    }()
    
    let nextButton: UIButton = {
        let btn = NextButton()
        btn.setTitle("워크스페이스 생성", for: .normal)
        return btn
    }()
    
    override func configureView() {
        addSubview(upperView)
        upperView.addSubview(closeButton)
        upperView.addSubview(titleLabel)
        addSubview(divider)
        
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(initialImage)
        addSubview(nextButton)
    }
    
    override func setConstraints() {
        
        upperView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(98)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalTo(closeButton.snp.trailing).offset(132)
            make.trailing.equalToSuperview().inset(164)
            make.centerY.equalTo(closeButton)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(35)

            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        initialImage.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(368)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-45)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        
        
    }
    
    
}
