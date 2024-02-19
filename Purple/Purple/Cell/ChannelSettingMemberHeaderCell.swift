//
//  ChannelSettingMemberHeaderCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/19/24.
//

import UIKit
import SnapKit

final class ChannelSettingMemberHeaderCell: BaseTableViewCell {
    
    static let identifier = "ChannelSettingMemberHeaderCell"
    
    let memberLabel = {
        let label = UILabel()
        label.text = "멤버 (17)"
        label.font = ConstantTypo.title2
        label.textColor = UIColor.brandBlack
        return label
    }()
    
    let foldImageView = {
        let view = UIImageView()
        view.image = ConstantIcon.chevronDown
        return view
    }()
    
    
    override func configureView() {
        
        contentView.addSubview(memberLabel)
        contentView.addSubview(foldImageView)
        
        contentView.backgroundColor = ConstantColor.bgPrimary
        
    }
    
    override func setConstraints() {
        
        memberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(28)
        }
        
        foldImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.width.equalTo(27)
            make.centerY.equalToSuperview()
        }
    }
    
}
