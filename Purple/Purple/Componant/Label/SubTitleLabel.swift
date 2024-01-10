//
//  SubTitleLabel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/9/24.
//

import UIKit

class SubTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        font = ConstantTypo.body
        textColor = ConstantColor.blackBrand
        numberOfLines = 0
        textAlignment = .center
    }
}
