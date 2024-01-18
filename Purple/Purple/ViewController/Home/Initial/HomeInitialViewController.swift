//
//  HomeInitialViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit

import RxSwift
import RxCocoa
import SideMenu

final class HomeInitialViewController: BaseViewController {
    
    var isOpen = [false, false]
    
    let sectionNames = ["채널", "다이렉트 메세지"]
    let dummyDataList = ["일반", "채널추가", "오예"]
    
    let mainView = HomeInitialView()
    let viewModel = HomeInitialViewModel()
    let disposeBag = DisposeBag()
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.homeTableView.delegate = self
        mainView.homeTableView.dataSource = self
        
        bind()
        
    }
    
    
    func bind() {
        
        let input = HomeInitialViewModel.Input(
            circleTap:
                mainView.navigationbarView.circleThumnailButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.circleTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    let vc = SideMenuNavigationController(rootViewController: SideMenuViewController())
                    
                    vc.leftSide = true
                    vc.presentationStyle = .menuSlideIn
                    vc.menuWidth = UIScreen.main.bounds.width - 76
                    vc.sideMenuDelegate = self
                    
                    self.present(vc, animated: true)
                    
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
    
    
}


extension HomeInitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeListCell.identifier, for: indexPath) as? HomeListCell else {return UITableViewCell() }
        
        return cell
    }
    
    
    
    
    
}

