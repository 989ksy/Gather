//
//  ChannelSettingViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/18/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ChannelSettingViewController: BaseViewController {
    
    let mainView = ChannelSettingView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.settingTableView.delegate = self
        mainView.settingTableView.dataSource = self
        
        bind()
        
    }
    
    
    func bind() {
        
        //뒤로 가기 버튼 누름
        mainView.customNavigationBarView.backButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                
                self.navigationController?.popViewController(animated: true)
                
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
}


extension ChannelSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
       return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            // 설명
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelSettingFirstSectionCell.identifier, for: indexPath) as? ChannelSettingFirstSectionCell else { return UITableViewCell()}
            
            cell.selectionStyle = .none
            
            
            return cell
            
        } else if indexPath.section == 1 {
            
            // 멤버폴딩
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelSettingMemberHeaderCell.identifier, for: indexPath) as? ChannelSettingMemberHeaderCell else { return UITableViewCell()}
            
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 2 {
            
            // 컬렉션뷰
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelSettingSecondSectionCell.identifier, for: indexPath) as? ChannelSettingSecondSectionCell else { return UITableViewCell()}
            
            cell.selectionStyle = .none

            return cell
         
        } else {
            
            // 버튼
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelSettingThirdSectionCell.identifier, for: indexPath) as? ChannelSettingThirdSectionCell else { return UITableViewCell()}
            
            cell.selectionStyle = .none

                        
            return cell
            
        }
                
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 100
            
        } else if indexPath.section == 1 {
            
            return 52
            
        } else if indexPath.section == 2 {
            
            return 350
            
        } else {
            
            return 280
            
        }
        
        
    }
    
    
    
    
    
    
}
