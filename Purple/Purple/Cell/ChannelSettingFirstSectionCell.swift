//
//  ChannelSettingCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/19/24.
//

import UIKit
import SnapKit


final class ChannelSettingFirstSectionCell: BaseTableViewCell {
    
    static let identifier = "ChannelSettingFirstSectionCell"
    
    let chatTitleLabel = {
        let label = UILabel()
        label.font = ConstantTypo.title2
        label.textColor = ConstantColor.blackBrand
        label.text = "#기아타이거즈"
        return label
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.text = "여기서 선수들은 경기 전략, 훈련 팁, 그리고 서로의 경험을 공유하며 개인 및 팀의 성장을 위해 노력합니다. 이곳은 동료 선수들과의 유대감을 강화하고, 팀 내 화합을 위한 소중한 시간을 보내는 장소로 활용됩니다."
        label.font = ConstantTypo.body
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 4)
        return label
    }()
    
    override func configureView() {
        
        addSubview(chatTitleLabel)
        addSubview(infoLabel)
        
        backgroundColor = ConstantColor.bgPrimary
        
    }
    
    override func setConstraints() {
        
        
        chatTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(chatTitleLabel.snp.bottom).offset(10)
            make.height.lessThanOrEqualTo(100)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
    }
    
    
}
