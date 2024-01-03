//
//  BaseView.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

class BaseView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
    }
    
    func setConstraints() {
        
    }
    
}
