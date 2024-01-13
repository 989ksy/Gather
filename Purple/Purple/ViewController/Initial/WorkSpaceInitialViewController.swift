//
//  WorkSpaceInitialViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/8/24.
//

import UIKit

final class WorkSpaceInitialViewController: BaseViewController {
    
    let mainView = WorkSpaceInitialView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = ConstantColor.bgPrimary
    }
    
}
