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
import Kingfisher

//워크스페이스 수에 따른 화면 재사용
enum transitionType: String {
    case one
    case multi
}

final class HomeDefaultViewController: BaseViewController, HeaderViewDelegate, UISheetPresentationControllerDelegate {
    
    let dummyDataList = ["일반", "스유 뽀개기", "오예스"] //cell 더미데이터
    
    var channelList = [readMyChannelResponse(
        workspaceID: 0,
        channelID: 0,
        name: "",
        description: "",
        ownerID: 0,
        privateNm: 0,
        createdAt: ""
    )]
    
    var workspaceIdForOne: Int? //로그인 -> WorksapceID 받음
    
    let mainView = HomeDefaultView()
    let viewModel = HomeDefaultViewModel()
    let disposeBag = DisposeBag()
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var type: transitionType = .one
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.homeTableView.delegate = self
        mainView.homeTableView.dataSource = self
        
        setNavigationbarView()
        bind()
                
    }
    
    //네비게이션바 영역 값전달
    func setNavigationbarView() {
        
        switch type {
            
        case .one:
            
            print("✅ 워크스페이스 한개_ 네비게이션뷰")
            
            //워크스페이스 타이틀
            guard let workspaceId = workspaceIdForOne else { return }
            
            viewModel.getTitleForOne(workspaceID: workspaceId)
                        
            viewModel.workspaceIdForOneContainer
                .subscribe(with: self) { owner, response in
                    
                    //타이틀
                    self.mainView.navigationbarView.titleLabel.text = response.name
                    print("title For One:", response.name)
                    
                    //썸네일
                    let thumURL = URL(string: BaseServer.base + response.thumbnail)
                    
                    owner.mainView.navigationbarView.groupThumImageView.loadImage(
                        from: thumURL!,
                        placeHolderImage: ConstantImage.rectangleProfile.image
                    )
                    
//                    owner.mainView.navigationbarView.groupThumImageView.kf.setImage(with: thumURL)
                    
                    print("====!!!! 사진", thumURL)
                    
                    
                }
                .disposed(by: disposeBag)
            
            //프로필 정보 가져오기
            
            viewModel.profileForOneContainer
                .subscribe(with: self) { owner, response in
                    
                    let profileURL = URL(string: BaseServer.base + (response.profileImage ?? ""))
                    
                    self.mainView.navigationbarView.circleThumImageView.loadImage(
                        from: profileURL!,
                        placeHolderImage: UIImage(systemName: "star.fill"))
                }
            
                .disposed(by: disposeBag)
            
            //채널
            viewModel.getChannelForOne(workspaceID: workspaceId)
            
            viewModel.channelListForOneContainer
                .subscribe(with: self) { owner, response in
                    
                    self.channelList = response
                    
                }
                .disposed(by: disposeBag)
            
            
            
                                                
        case .multi:
            
            print("✅ 워크스페이스 여러 개_ 네비게이션뷰")
            
        }
        
        
    }
    
    
    func bind() {
        
        let input = HomeDefaultViewModel.Input(
            circleTap:
                mainView.navigationbarView.circleThumnailButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        //사이드바 불러오기
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
        
        switch type {

        case .one:
            
            //채널
            if section == 0 {
                            
                //여닫기
                headerView.sectionIndex = section //섹션 넘김
                headerView.delegate = self //딜리게이트
                headerView.isOpened = viewModel.isOpen[section] //불값에 따라 화살표 아이콘
                
                headerView.sectionTitleLabel.text = viewModel.sectionList[section] //섹션 타이틀
                
                headerView.sectionTitleLabel.isHidden = false
                headerView.foldImageView.isHidden = false
                headerView.addMemberButtonView.isHidden = true
                
            } 
            
            //다이렉트 메세지
            else if section == 1 {
                
                //여닫기
                headerView.sectionIndex = section //섹션 넘김
                headerView.delegate = self //딜리게이트
                headerView.isOpened = viewModel.isOpen[section] //불값에 따라 화살표 아이콘
                
                headerView.sectionTitleLabel.text = viewModel.sectionList[section] //섹션 타이틀
                
                headerView.sectionTitleLabel.isHidden = false
                headerView.foldImageView.isHidden = false
                headerView.addMemberButtonView.isHidden = true
                
            }
            
            //팀원추가
            else {
                
                headerView.sectionTitleLabel.isHidden = true
                headerView.addMemberButtonView.isHidden = false
                
                headerView.addMemberButtonView.titleLabel.text = viewModel.sectionList[section]
                headerView.addMemberButtonView.iconImageView.image = ConstantIcon.plusCustom
                
                //팀원초대 화면전환
                headerView.addMemberButtonView.customButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        
                        print("팀원 초대창 나옴")
                        
                        let vc = InviteMemberViewController()
                        vc.modalPresentationStyle = .pageSheet
                        
                        if let sheet = vc.sheetPresentationController {
                            sheet.detents = [.large()]
                            sheet.delegate = self
                            sheet.prefersGrabberVisible = true
                        }
                        
                        self.present(vc, animated: true, completion: nil)

                    }
                    .disposed(by: disposeBag)
                
                headerView.foldImageView.isHidden = true
                headerView.dividerUp.isHidden = true
                headerView.dividerBottom.isHidden = true
            }
            
            return headerView
            
            
        case .multi:
            
            if section == 0 || section == 1 {
                            
                //여닫기
                headerView.sectionIndex = section //섹션 넘김
                headerView.delegate = self //딜리게이트
                headerView.isOpened = viewModel.isOpen[section] //불값에 따라 화살표 아이콘
                
                headerView.sectionTitleLabel.text = viewModel.sectionList[section] //섹션 타이틀
                
                headerView.sectionTitleLabel.isHidden = false
                headerView.foldImageView.isHidden = false
                headerView.addMemberButtonView.isHidden = true
                
            } else {
                
                headerView.sectionTitleLabel.isHidden = true
                headerView.addMemberButtonView.isHidden = false

                
                headerView.addMemberButtonView.titleLabel.text = viewModel.sectionList[section]
                headerView.addMemberButtonView.iconImageView.image = ConstantIcon.plusCustom
                
                headerView.foldImageView.isHidden = true
                headerView.dividerUp.isHidden = true
                headerView.dividerBottom.isHidden = true
            }
            
            return headerView
        }
        
    }
    
    //섹션 접었다 폈다
    func didTouchSection(_ sectionIndex: Int) {
                
        self.viewModel.isOpen[sectionIndex].toggle()
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
        
        //맨 마지막 섹션일 땐 셀 없음
        if section == 2 { return 0 }
        
        
        if viewModel.isOpen[section] == true {
            
            if section == 0 {
                // 첫번째 섹션일 경우 채널리스트
                return channelList.count + 1
                
            } else if section == 1 {
                
                return dummyDataList.count + 1
                
            }
            
        }
        
        return 0
        
    }
    
    //셀꾸
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeListCell.identifier, for: indexPath) as? HomeListCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            
            cell.directionMessageView.isHidden = true
            cell.chanelListView.isHidden = false
            
            if indexPath.row < [channelList].count {
                
                let data = [channelList][indexPath.row]
                
                for item in data {
                    
                    cell.chanelListView.titleLabel.text = item.name
                    cell.chanelListView.iconImageView.image = ConstantIcon.hashThin

                }

            } else if indexPath.row == 0 {
                
                cell.chanelListView.titleLabel.text = "일반"
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
        
        switch type {
            
        case .one:
            
            //채널추가 눌렀을 때 액션시트
            if indexPath.section == 0 && indexPath.row == self.channelList.count + 1  {
                    
                    let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
                    let createChannel = UIAlertAction(title: "채널생성", style: .default)
                    let exploreChannel = UIAlertAction(title: "채널탐색", style: .default)
                    let cancel = UIAlertAction(title: "취소", style: .cancel)
                    
                    alert.addAction(createChannel)
                    alert.addAction(exploreChannel)
                    alert.addAction(cancel)
                    
                self.present(alert, animated: true)
                
            }
            
        case .multi:
            
            if indexPath.section == 0 && indexPath.row == dummyDataList.count + 1  {
                    
                    let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
                    let createChannel = UIAlertAction(title: "채널생성", style: .default)
                    let exploreChannel = UIAlertAction(title: "채널탐색", style: .default)
                    let cancel = UIAlertAction(title: "취소", style: .cancel)
                    
                    alert.addAction(createChannel)
                    alert.addAction(exploreChannel)
                    alert.addAction(cancel)
                    
                self.present(alert, animated: true)
                
            }
        }
        
        //선택 시 회색셀렉션 제거
        tableView.reloadRows(at: [indexPath], with: .none)
        
        
    }
    
    
    
}

