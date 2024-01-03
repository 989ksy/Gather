//
//  BaseViewController.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = ConstantColor.bgPrimary
        
    }
    
    func setConstraints() {
        
    }
    
    
    
}
