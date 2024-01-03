//
//  NextButton + Extension.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

class NextButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting() {
        setTitleColor(.white, for: .normal)
        backgroundColor = ConstantColor.inActiveBrand
        layer.cornerRadius = 8
        titleLabel?.font = ConstantTypo.title2
        
    }
    
    
}
