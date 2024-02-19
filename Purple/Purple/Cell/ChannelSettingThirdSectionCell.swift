//
//  ChannelSettingThirdSectionCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/19/24.
//

import UIKit
import SnapKit


final class ChannelSettingThirdSectionCell: BaseTableViewCell {
    
    static let identifier = "ChannelSettingThirdSectionCell"
    
    let editButton = {
        let btn = NextButton()
        btn.setTitle("채널 편집", for: .normal)
        btn.setTitleColor(ConstantColor.blackBrand, for: .normal)
        btn.backgroundColor = ConstantColor.whiteBrand
        btn.layer.borderWidth = 1
        btn.layer.borderColor = ConstantColor.blackBrand?.cgColor
        return btn
    }()
    
    let leaveButton = {
        let btn = NextButton()
        btn.setTitle("채널에서 나가기", for: .normal)
        btn.backgroundColor = ConstantColor.whiteBrand
        btn.setTitleColor(ConstantColor.blackBrand, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = ConstantColor.blackBrand?.cgColor
        return btn
    }()
    
    let changeManagerButton = {
        let btn = NextButton()
        btn.setTitle("채널 관리자 변경", for: .normal)
        btn.backgroundColor = ConstantColor.whiteBrand
        btn.setTitleColor(ConstantColor.blackBrand, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = ConstantColor.blackBrand?.cgColor
        return btn
    }()
    
    let deleteButton = {
        let btn = NextButton()
        btn.setTitle("채널 삭제", for: .normal)
        btn.backgroundColor = ConstantColor.whiteBrand
        btn.layer.borderWidth = 1
        btn.layer.borderColor = ConstantColor.errorBrand?.cgColor
        btn.setTitleColor(ConstantColor.errorBrand, for: .normal)
        return btn
    }()
    
    
    override func configureView() {
        
        contentView.addSubview(editButton)
        contentView.addSubview(leaveButton)
        contentView.addSubview(changeManagerButton)
        contentView.addSubview(deleteButton)
        
        backgroundColor = ConstantColor.bgPrimary

        
    }
    
    override func setConstraints() {
        
        editButton.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            
        }
        
        leaveButton.snp.makeConstraints { make in
            
            make.top.equalTo(editButton.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            
        }
        
        changeManagerButton.snp.makeConstraints { make in
            
            make.top.equalTo(leaveButton.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            
            
        }
        
        deleteButton.snp.makeConstraints { make in
            
            make.top.equalTo(changeManagerButton.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            
            
        }
       
        
    }
    
    
}
