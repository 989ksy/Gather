//
//  OnboardingView.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.font = ConstantTypo.title1
        label.setLineSpacing(spacing: 30)
        label.textColor = ConstantColor.blackBrand
        label.text = "게더를 사용하면 어디서나\n팀을 모을 수 있습니다"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let onboardingImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = ConstantImage.onboardingImage
        return view
    }()
    
    let startButton: UIButton = {
        let btn = NextButton()
        btn.setTitle("시작하기", for: .normal)
        btn.backgroundColor = ConstantColor.purpleBrand
        return btn
    }()
    
    override func configureView() {
        addSubview(introLabel)
        addSubview(onboardingImage)
        addSubview(startButton)
    }
    
    override func setConstraints() {
        
        introLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(93)
            make.width.equalTo(345)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        onboardingImage.snp.makeConstraints { make in
            make.top.equalTo(242)
            make.centerX.equalToSuperview()
            make.size.equalTo(368)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(763)
            make.height.equalTo(44)
            make.width.equalTo(345)
        }
        
    }
    
    
}
