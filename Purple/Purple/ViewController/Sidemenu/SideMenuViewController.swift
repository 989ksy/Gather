//
//  SideMenuViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SideMenu

final class SideMenuViewController: BaseViewController {
    
    let mainView = SideMenuView()
    
    override func loadView() {
        self.view = SideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantColor.bgSecondary
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        
    }
    
}
