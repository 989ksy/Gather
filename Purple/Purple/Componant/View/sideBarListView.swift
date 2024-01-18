//
//  sideBarListView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/18/24.
//

import UIKit
import SnapKit

final class sidebarListView: UIView {
    
    let thumImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.image = ConstantImage.rectangleProfile.image
        return view
    }()
    
    let stackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "Kia Tigers"
        label.textColor = UIColor.brandBlack
        label.font = ConstantTypo.bodyBold
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "yy.MM.dd"
        label.font = ConstantTypo.body
        label.textColor = UIColor.textSecondary
        return label
    }()
    
    let threeDotsButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.threeDots, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
        backgroundColor = UIColor.backgroundPrimary
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(thumImageView)
        addSubview(threeDotsButton)
        addSubview(stackView)
    }
    
    func setConstraints() {
        
        thumImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(thumImageView.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(50)
        }
        
        threeDotsButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalTo(stackView.snp.trailing).offset(18)
            make.centerY.equalToSuperview()
        }
    }
    
    
}
