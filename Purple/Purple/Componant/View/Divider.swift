//
//  Divider.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

class Divider: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDivider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDivider() {
        backgroundColor = ConstantColor.seperator
    }
}
