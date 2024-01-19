//
//  SideMenuTableViewCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/18/24.
//

import UIKit
import SnapKit

final class SideMenuTableViewCell: BaseTableViewCell {
    
    static let identifier = "SideMenuTableViewCell"
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
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
        btn.setImage(ConstantIcon.threeDots?.withTintColor(.brandBlack), for: .normal)
        return btn
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = ""
        thumImageView.image = nil
        titleLabel.text = ""

    }
    
    override func configureView() {
        backgroundColor = UIColor.backgroundSecondary
        
        contentView.addSubview(backView)
        backView.addSubview(thumImageView)
        backView.addSubview(threeDotsButton)
        backView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        
    }
    
    override func setConstraints() {
        
        backView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(3)
            make.horizontalEdges.equalToSuperview().inset(1)
        }
        
        thumImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(thumImageView.snp.trailing).offset(10)
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
