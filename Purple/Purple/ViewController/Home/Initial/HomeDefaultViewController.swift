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

final class HomeDefaultViewController: BaseViewController, HeaderViewDelegate {
    
    
    var isOpen = [true, true] //섹션 폴딩값

    let sectionList: [String] = ["채널", "다이렉트 메세지", "팀원추가"]
    let dummyDataList = ["일반", "스유 뽀개기", "오예스"] //cell 더미데이터
    
    let mainView = HomeDefaultView()
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


extension HomeDefaultViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - 섹션
    
    //섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    //헤더설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //헤더뷰 등록
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeDefaultHeaderView.identifier) as? HomeDefaultHeaderView else { return UITableViewHeaderFooterView() }
        
        
        if section == 0 || section == 1 {
                        
            //여닫기
            headerView.sectionIndex = section //섹션 넘김
            headerView.delegate = self
            headerView.isOpened = isOpen[section] //불값에 따라 화살표 아이콘
            
            headerView.sectionTitleLabel.text = sectionList[section] //섹션 타이틀
            
            headerView.sectionTitleLabel.isHidden = false
            headerView.foldImageView.isHidden = false
            headerView.addMemberButtonView.isHidden = true
            
        } else {
            
            headerView.sectionTitleLabel.isHidden = true
            headerView.addMemberButtonView.isHidden = false

            
            headerView.addMemberButtonView.titleLabel.text = sectionList[section]
            headerView.addMemberButtonView.iconImageView.image = ConstantIcon.plusCustom
            
            headerView.foldImageView.isHidden = true
            headerView.dividerUp.isHidden = true
            headerView.dividerBottom.isHidden = true
        }
        
        return headerView
    }
    
    //섹션 접었다 폈다
    func didTouchSection(_ sectionIndex: Int) {
                
        self.isOpen[sectionIndex].toggle()
        self.mainView.homeTableView.reloadSections([sectionIndex], with: .none)
        
    }
    
    //헤더 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 56
        } else {
            return 41
        }
    }
    
    //MARK: - rows
    
    //개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 { return 0 }
        
        if isOpen[section] == true {
            return dummyDataList.count + 1
        } else {
            return 0
        }
        
    }
    
    //셀꾸
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeListCell.identifier, for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            
            cell.directionMessageView.isHidden = true
            cell.chanelListView.isHidden = false
            
            if indexPath.row < dummyDataList.count {
                
                let data = dummyDataList[indexPath.row]
                cell.chanelListView.titleLabel.text = data
                cell.chanelListView.iconImageView.image = ConstantIcon.hashThin

            } else {
                
                cell.chanelListView.titleLabel.text = "채널 추가"
                cell.chanelListView.iconImageView.image = ConstantIcon.plusCustom

            }
        } else if indexPath.section == 1 {
            
            if indexPath.row < dummyDataList.count {
                
                cell.chanelListView.isHidden = true
                cell.directionMessageView.isHidden = false
                
                let data = dummyDataList[indexPath.row]
                
                cell.directionMessageView.messageLabel.text = data
                cell.directionMessageView.thumImage.image = UIImage(systemName: "star")

                
            } else {
                
                cell.chanelListView.isHidden = false
                cell.directionMessageView.isHidden = true
                
                cell.chanelListView.titleLabel.text = "새 메세지 시작"
                cell.chanelListView.iconImageView.image = ConstantIcon.plusCustom
            }
        }

        
        return cell
    }
    
    //셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 41
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //선택 시 회색셀렉션 제거
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
    
    
}

