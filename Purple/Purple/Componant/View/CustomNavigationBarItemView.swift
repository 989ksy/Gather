//
//  CustomNavigationBarItemView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit
import SnapKit

class CustomNavigationBarItemView: UIView {
    
    let groupThumImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.image = ConstantImage.rectangleProfile.image
        view.clipsToBounds = true

        return view
    }()
    
    let titleLabel = {
        let label = TitleLabel()
        label.text = "No Workspace"
        return label
    }()
    
    let circleThumnailButton = {
        let btn = UIButton()
        return btn
    }()
    
    let circleThumImageView = {
        let view = UIImageView()
        view.image = ConstantImage.circleProfile.image
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
        
        addSubview(groupThumImageView)
        addSubview(titleLabel)
    
        addSubview(circleThumImageView)
        addSubview(circleThumnailButton)
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
        
        groupThumImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(divider.snp.top).offset(-14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(groupThumImageView.snp.trailing).offset(8)
            make.trailing.equalTo(circleThumImageView.snp.leading).inset(12)
            make.height.equalTo(35)
            make.centerY.equalTo(groupThumImageView)
        }
        
        circleThumImageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(groupThumImageView)
        }
        
        circleThumnailButton.snp.makeConstraints { make in
            make.size.equalTo(circleThumImageView)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(groupThumImageView)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}
