//
//  SignupTextField.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

class SignupTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextField() {
        addLeftPadding() // 왼쪽여백 12
        font = ConstantTypo.body
        textColor = ConstantColor.blackBrand
        backgroundColor = ConstantColor.whiteBrand
        layer.cornerRadius = 8
        borderStyle = .none
        autocapitalizationType = .none
        
    }
    
}
