//
//  HomeDefaultView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SnapKit

final class HomeDefaultView: BaseView {
    
    let navigationbarView = {
        let view = CustomNavigationBarItemView()
        return view
    }()
    
    let homeTableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.sectionHeaderTopPadding = 0
        view.isScrollEnabled = false
        view.register(HomeListCell.self, forCellReuseIdentifier: HomeListCell.identifier)
        view.register(HomeDefaultHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeDefaultHeaderView.identifier)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        return view
    }()
    
    let newButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.newMessageButton, for: .normal)
        return btn
    }()
    
    
    override func configureView() {

        addSubview(navigationbarView)
        addSubview(homeTableView)
        addSubview(newButton)
    }
    
    override func setConstraints() {
        
        
        navigationbarView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(56)
            make.horizontalEdges.equalToSuperview()
        }
        
        homeTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationbarView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        newButton.snp.makeConstraints { make in
            make.size.equalTo(54)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-95)
        }
        
    }
    
}
