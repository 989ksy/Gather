//
//  ChannelNavigationBarView.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import SnapKit

class ChannelNavigationBarView: UIView {
    
    let backButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.chevronLeft?.withTintColor(.brandBlack), for: .normal)
        return btn
    }()
    
    let channelTitleLabel = {
        let txt = NavigationTitleLabel()
        txt.textAlignment = .center
        txt.text = "#제목 텍스트"
        return txt
    }()
    
    let countLabel = {
        let txt = NavigationTitleLabel()
        txt.textAlignment = .center
        txt.text = "63"
        txt.textColor = ConstantColor.txtSecondary
        return txt
    }()
    
    let listButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.listCustom?.withTintColor(.brandBlack), for: .normal)
        return btn
    }()
    
    let divider = {
        let view = Divider()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ConstantColor.bgSecondary
        
        addSubview(backButton)
        addSubview(channelTitleLabel)
        addSubview(countLabel)
        addSubview(listButton)
        addSubview(divider)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(17)
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
        }
        
        channelTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.equalTo(channelTitleLabel.snp.trailing).offset(4)
            make.height.equalTo(22)
        }
        
        listButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(18)
            make.height.equalTo(16)
        }
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    
}

