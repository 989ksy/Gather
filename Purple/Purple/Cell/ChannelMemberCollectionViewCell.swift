//
//  ChannelMemberCollectionViewCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/19/24.
//

import UIKit
import SnapKit

final class ChannelMemberCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "ChannelMemberCollectionViewCell"
    
    let profileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let userNameLabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = ConstantTypo.body
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func prepareForReuse() {
        
        self.profileImageView.image = nil
        self.userNameLabel.text = ""
        
    }
    
    override func configureView() {
        backgroundColor = ConstantColor.bgPrimary
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(userNameLabel)
        
    }
    
    override func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(4)
            make.height.equalTo(18)
            make.centerX.equalToSuperview()
        }
        
    }
    
    
}
