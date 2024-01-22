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
    
    let chanelListView = {
        let view = HomeListView()
        return view
    }()
    
    let directionMessageView = {
        let view = DirectMessageView()
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //채널
        chanelListView.isHidden = true
        chanelListView.iconImageView.image = nil
        chanelListView.titleLabel.text = nil
        
        //메세지
        directionMessageView.isHidden = true
        directionMessageView.messageLabel.text = nil
        directionMessageView.thumImage.image = nil
        
    }
    
    
    override func configureView() {
        
        addSubview(chanelListView)
        addSubview(directionMessageView)
        
    }
    
    override func setConstraints() {
        
        chanelListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        directionMessageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}
