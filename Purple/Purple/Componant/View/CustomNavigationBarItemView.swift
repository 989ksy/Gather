//
//  CustomNavigationBarItemView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit
import SnapKit

class CustomNavigationBarItemView: UIView {
    
    let groupProfileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.image = ConstantImage.rectangleProfile.image
        view.clipsToBounds = true

        return view
    }()
    
    let titleLabel = {
        let label = TitleLabel()
        label.text = "Title"
        return label
    }()
    
    let circleProfileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = ConstantColor.txtPrimary?.cgColor
        return view
    }()
    
    let divider = {
        let view = Divider()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(groupProfileImageView)
        addSubview(titleLabel)
        addSubview(circleProfileImageView)
        addSubview(divider)
        
        setConstraints()
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCustomView() {
        backgroundColor = ConstantColor.bgPrimary
    }
    
    func setConstraints() {
        
        groupProfileImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(divider.snp.top).offset(-14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(groupProfileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(circleProfileImageView.snp.leading).inset(12)
            make.height.equalTo(35)
            make.centerY.equalTo(groupProfileImageView)
        }
        
        circleProfileImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(groupProfileImageView)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}
