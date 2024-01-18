//
//  CustomPresentNavigationBarView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/16/24.
//

import UIKit
import SnapKit

class CustomPresentNavigationBarView: UIView {
    
    let navigationTitleLable = {
        let label = NavigationTitleLabel()
        label.textAlignment = .center
        return label
    }()
    
    let closeButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.close, for: .normal)
        return btn
    }()
    
    let divider = {
        let view = Divider()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(navigationTitleLable)
        addSubview(closeButton)
        addSubview(divider)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(29)
        }
        
        navigationTitleLable.snp.makeConstraints { make in
            
            make.centerY.equalTo(closeButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    
}
