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
    
    var listView = {
        let view = sidebarListView()
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        listView.dateLabel.text = nil
        listView.thumImageView.image = nil
        listView.titleLabel.text = nil

    }
    
    override func configureView() {
        addSubview(listView)
        backgroundColor = UIColor.backgroundPrimary
    }
    
    override func setConstraints() {
        listView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(1)
        }
    }
    
    
}
