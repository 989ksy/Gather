//
//  SignupTitleLabel.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

class SignupTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLabel() {
        font = ConstantTypo.title2
        textColor = ConstantColor.blackBrand
    }
    
}
