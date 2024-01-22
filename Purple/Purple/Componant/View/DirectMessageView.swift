//
//  DirectMessageView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/22/24.
//

import UIKit
import SnapKit

final class DirectMessageView: UIView {
    
    //썸네일 이미지 + 레이블
    
    let thumImage = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let messageLabel = {
        let label = UILabel()
        label.font = ConstantTypo.body
        label.textColor = ConstantColor.txtSecondary
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(thumImage)
        addSubview(messageLabel)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - thum
    
    func setConstraints() {
        
        thumImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
        }

        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumImage.snp.trailing).offset(8)//
            make.height.equalTo(18)
            make.trailing.lessThanOrEqualToSuperview().inset(43)//
            make.centerY.equalTo(thumImage)
        }
        
    }
    
    
    
}
