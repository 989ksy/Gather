//
//  ChattingCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/8/24.
//

import UIKit
import SnapKit

final class ChattingCell: BaseTableViewCell {
    
    static let identifier = "ChattingCell"
    
    let profileImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .gray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let userNameLabel = {
        let label = UILabel()
        label.textColor = ConstantColor.blackBrand
        label.setLineSpacing(spacing: 18)
        label.font = ConstantTypo.caption
        return label
    }()
    
    let messageTextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.isEditable = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = ConstantColor.inActiveBrand?.cgColor
        view.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        view.font = ConstantTypo.body
        view.sizeToFit() //텍스트 길이에 맞게 사이즈를 맞춰
        return view
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = ConstantTypo.caption2
        label.textColor = ConstantColor.txtSecondary
        label.backgroundColor = .clear
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        userNameLabel.text = ""
        messageTextView.text = ""
        dateLabel.text = ""
        
    }
    
    
    override func configureView() {
        
        backgroundColor = ConstantColor.bgSecondary
        selectionStyle = .none
                
        contentView.addSubview(profileImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(messageTextView)
        contentView.addSubview(dateLabel)

    }
    
//    func configureCell(cell: ChattingCell, indexPath: IndexPath) {
//        
//        
//        profileImageView.image = cell.profileImageView.image
//        messageTextView.text = cell.messageTextView.text
//        userNameLabel.text = cell.userNameLabel.text
//        dateLabel.text = cell.dateLabel.text
//        
//    }
    
    override func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(34)
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
            make.trailing.lessThanOrEqualToSuperview().inset(74)
            make.top.equalToSuperview().offset(6)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().inset(74)
            make.bottom.equalToSuperview().inset(6)

        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.leading.equalTo(messageTextView.snp.trailing).offset(8)
            make.bottom.equalTo(messageTextView)
            make.trailing.lessThanOrEqualToSuperview().inset(1)
        }
        
        
        
        
    }
    
    
}
