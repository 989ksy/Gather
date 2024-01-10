//
//  TitleLabel.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/9/24.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        font = ConstantTypo.title1
        textColor = ConstantColor.blackBrand
    }
}
