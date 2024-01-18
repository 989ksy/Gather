//
//  HomeListCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SnapKit

final class HomeListCell: BaseTableViewCell {
    
    static let identifier = "HomeListCell"
    
    let listView = {
        let view = HomeListView()
        return view
    }()
    
    
    override func configureView() {
        
        addSubview(listView)
        
    }
    
    override func setConstraints() {
        
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}
