//
//  TitleLabel.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

class NavigationTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel() {
        font = UIFont.systemFont(ofSize: 17, weight: .bold)
        textColor = ConstantColor.blackBrand
    }
}
