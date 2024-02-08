//
//  CustomPopupView.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import SnapKit

//팝업창
final class CustomPopupView: UIView {
    
    //백그라운드
    let alphaView = {
        let view = UIView()
        return view
    }()
    
    //팝업창 배경
    let popBackView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.whiteBrand
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleLabel = {
        let text = UILabel()
        text.font = ConstantTypo.title2
        text.textColor = ConstantColor.txtPrimary
        text.text = "제목 테스트"
        return text
    }()
    
    let contentLabel = {
        let text = UILabel()
        text.font = ConstantTypo.body
        text.textColor = ConstantColor.txtSecondary
        text.textAlignment = .center
        text.setLineSpacing(spacing: 18)
        text.numberOfLines = 0
        return text
    }()
    
    let stackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.spacing = 8
        return view
    }()
    
    let cancelButton = {
        let btn = NextButton()
        btn.setTitle("취소", for: .normal)
        return btn
    }()
    
    let okButton = {
        let btn = NextButton()
        btn.setTitle("확인", for: .normal)
        btn.backgroundColor = ConstantColor.purpleBrand
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(alphaView)
        alphaView.addSubview(popBackView)
        popBackView.addSubview(titleLabel)
        popBackView.addSubview(contentLabel)
        popBackView.addSubview(stackView)
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(okButton)
    }
    
    func setConstraints() {
        
        alphaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popBackView.snp.makeConstraints { make in
            make.width.equalTo(344)
            make.height.greaterThanOrEqualTo(156)
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(popBackView.snp.top).offset(16)
            make.centerX.equalTo(popBackView)
            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16.5)
            make.height.greaterThanOrEqualTo(40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(312)
            make.height.equalTo(44)
        }
        
        
        
        
    }
    
    
}
