//
//  CustomTabbarViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit

class CustomTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //탭바 배경색
        self.tabBar.backgroundColor = .brandWhite
        
        //탭바 설정
        //홈
        let homeTab = HomeDefaultViewController()
        let homeTabItem = UITabBarItem(title: "홈", image: ConstantIcon.homeCustom, tag: 0)
        homeTab.tabBarItem = homeTabItem
        homeTab.tabBarItem.selectedImage = ConstantIcon.homeActive?.withRenderingMode(.alwaysOriginal)
        
        //DM
        let dmTab = DMViewController()
        let dmTabItem = UITabBarItem(title: "DM", image: ConstantIcon.messageCustom, tag: 1)
        dmTab.tabBarItem = dmTabItem
        dmTab.tabBarItem.selectedImage = ConstantIcon.messageActive?.withRenderingMode(.alwaysOriginal)

        //검색
        let searchTab = SearchViewController()
        let searchTabItem = UITabBarItem(title: "검색", image: ConstantIcon.profile, tag: 2)
        searchTab.tabBarItem = searchTabItem
        searchTab.tabBarItem.selectedImage = ConstantIcon.profileActive?.withRenderingMode(.alwaysOriginal)
        
        //설정
        let settingTab = SettingViewController()
        let settingTabItem = UITabBarItem(title: "설정", image: ConstantIcon.setting, tag: 3)
        settingTab.tabBarItem = settingTabItem
        settingTab.tabBarItem.selectedImage = ConstantIcon.settingActive?.withRenderingMode(.alwaysOriginal)
        
        //탭바 - 폰트컬러
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brandInactive]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brandBlack]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        self.viewControllers = [homeTab, dmTab, searchTab, settingTab]
    }
}
