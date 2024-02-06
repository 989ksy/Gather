//
//  HomeCellView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SnapKit

final class HomeListView: UIView {
    
    //리스트뷰
    //아이콘 + 내용 레이블
    
    let customButton = {
        let btn = UIButton()
        return btn
    }()
    
    let iconImageView = {
        let view = UIImageView()
        view.image = ConstantIcon.hashThin
        return view
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.font = ConstantTypo.body
        label.textColor = UIColor.textSecondary
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(customButton)

    }
    
    func setConstraints() {
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.size.equalTo(18)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(16)
            make.height.equalTo(28)
            make.width.equalTo(290)
            make.centerY.equalTo(iconImageView)
        }
        
        customButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
}
