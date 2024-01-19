//
//  BlurEffect + Expension.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/18/24.
//

import UIKit
import SideMenu

extension HomeDefaultViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.tabBarController?.tabBar.backgroundColor = ConstantColor.alpha
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.tabBarController?.tabBar.backgroundColor = .white
        blurEffectView.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
    }

}
