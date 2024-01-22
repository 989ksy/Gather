//
//  HomeSectionTitleView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SnapKit

final class HomeSectionTitleView: UIView {
    
    let sectionTitleLabel = {
        let label = UILabel()
        label.text = "섹션 테스트"
        label.font = ConstantTypo.title2
        label.textColor = UIColor.brandBlack
        return label
    }()
    
    let foldButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.chevronRight, for: .normal)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        addSubview(sectionTitleLabel)
        addSubview(foldButton)
    }
    
    func setConstraints() {
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(28)
            make.top.equalToSuperview().inset(14)
//            make.centerY.equalToSuperview()
        }
        
        foldButton.snp.makeConstraints { make in
            make.width.equalTo(26.8)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(sectionTitleLabel)
        }
        
    }
    
    
}
