//
//  CloseButton.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setButton() {
        setImage(ConstantIcon.close, for: .normal)
    }
    
    
}
