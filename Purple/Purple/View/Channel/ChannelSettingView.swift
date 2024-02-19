//
//  ChannelSettingView.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/18/24.
//

import UIKit
import SnapKit

final class ChannelSettingView: BaseView {
    
    // MARK: - 네비게이션 영역
    
    let emptyView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.bgSecondary
        return view
    }()
    
    let customNavigationBarView = {
        
        let view = ChannelNavigationBarView()
        view.listButton.isHidden = true
        view.channelTitleLabel.text = "채널 설정"
        view.countLabel.isHidden = true
        return view
        
    }()
    
    // MARK: - 테이블뷰 영역
    
    let settingTableView = {
        let view = UITableView()
        view.register(
            ChannelSettingFirstSectionCell.self,
            forCellReuseIdentifier:
                ChannelSettingFirstSectionCell.identifier
        )
        view.register(
            ChannelSettingSecondSectionCell.self,
            forCellReuseIdentifier:
                ChannelSettingSecondSectionCell.identifier
        )
        view.register(ChannelSettingThirdSectionCell.self, forCellReuseIdentifier: ChannelSettingThirdSectionCell.identifier)
        view.register(ChannelSettingMemberHeaderCell.self, forCellReuseIdentifier: ChannelSettingMemberHeaderCell.identifier)
        view.backgroundColor = ConstantColor.bgPrimary
        view.separatorStyle = .none
        return view
    }()
        
    
    override func configureView() {
        
        addSubview(emptyView)
        addSubview(customNavigationBarView)
        
        addSubview(settingTableView)
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
            
        customNavigationBarView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(54)
            make.horizontalEdges.equalToSuperview()
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBarView.snp.bottom)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }

        
    }
    
    
    
}
