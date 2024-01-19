//
//  SideMenuView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/18/24.
//

import UIKit
import SnapKit

final class SideMenuView: BaseView {
    
    let workspaceTitleBackView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundPrimary
        return view
    }()
    
    let workspaceTitle = {
        let label = UILabel()
        label.text = "워크스페이스"
        label.font = ConstantTypo.title1
        label.textColor = UIColor.brandBlack
        return label
    }()
    
    let addButton = {
        let view = HomeListView()
        view.titleLabel.text = "워크스페이스 추가"
        view.iconImageView.image = ConstantIcon.plusCustom
        return view
    }()
    
    let guideButton = {
        let view = HomeListView()
        view.iconImageView.image = ConstantIcon.helpCustom
        view.titleLabel.text = "도움말"
        return view
    }()
    
    let sideMenuTableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.brandWhite
        view.register(
            SideMenuTableViewCell.self,
            forCellReuseIdentifier:
                SideMenuTableViewCell.identifier
        )
        return view
    }()
    
    let noDataView = {
        let view = WorkspaceNoDataView()
        return view
    }()
    
    override func configureView() {
        backgroundColor = ConstantColor.bgSecondary
        layer.cornerRadius = 25
        clipsToBounds = true
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        addSubview(workspaceTitleBackView)
        workspaceTitleBackView.addSubview(workspaceTitle)
        
        addSubview(addButton)
        addSubview(guideButton)
        
        addSubview(noDataView)
        addSubview(sideMenuTableView)


        
    }
    
    override func setConstraints() {
        
        workspaceTitleBackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(116)
        }
        
        workspaceTitle.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(17)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(74)
        }
        
        guideButton.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(addButton.snp.bottom)
        }
        
        sideMenuTableView.snp.makeConstraints { make in
            make.top.equalTo(workspaceTitleBackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top)
        }
        
        noDataView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(workspaceTitleBackView.snp.bottom).offset(183)
            make.horizontalEdges.equalToSuperview()
        }
        
        
    }
    
    
}
