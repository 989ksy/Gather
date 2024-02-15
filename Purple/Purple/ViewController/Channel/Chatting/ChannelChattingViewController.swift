//
//  ChannelChattingViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import RxSwift
import RxCocoa


struct dummyDataList {
    
    let profile: UIImage
    let name: String
    let content: String
    let date: String
    
}

final class ChannelChattingViewController: BaseViewController {
    
    //테스트용
    let dummyList: [dummyDataList] = [
        dummyDataList(profile: ConstantImage.launching.image!, name: "나성범", content: "타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아타이거즈 나성범 안타 안타 날려라 날려라 나성범 타이거즈 나성범 홈런~~~~~ 아 타이거", date: "08:16 오전"),
        dummyDataList(profile: UIImage(systemName: "heart.fill")!, name: "양현종", content: "양현종 대투수 짱~", date: "08:16 오전"),
        dummyDataList(profile: UIImage(systemName: "star")!, name: "이의리", content: "네모 안에 공을 넣어", date: "08:17 오전"),
        dummyDataList(profile: UIImage(systemName: "star.fill")!, name: "최형우", content: "낡지마 최형우", date: "08:17 오전"),
        dummyDataList(profile: UIImage(systemName: "house")!, name: "김선빈", content: "작은 거인 기아의 김선빈~", date: "08:17 오전"),
        dummyDataList(profile: UIImage(systemName: "heart")!, name: "박찬호", content: "기아 박찬호 호~", date: "08:18 오전"),
        dummyDataList(profile: UIImage(systemName: "heart.fill")!, name: "이우성", content: "우성신", date: "08:18 오전"),
        dummyDataList(profile: UIImage(systemName: "star")!, name: "윤영철", content: "고졸신인이 퀄스 했으면 승투 먹여야할거아냐", date: "08:20 오전"),
        dummyDataList(profile: UIImage(systemName: "star")!, name: "이범호", content: "잘생겼다 이범호", date: "08:25 오전"),
        dummyDataList(profile: ConstantImage.onboarding.image!, name: "김도영", content: "그런 날 있잖아 홈런 치고 챔필런 하고 싶은 그런 날", date: "08:29 오전")
    ]
    
    let mainView = ChannelChattingView()
    let viewModel = ChannelChattingViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainView.chattingTableView.delegate = self
        mainView.chattingTableView.dataSource = self
        
        bind()
        
        //채팅방 타이틀
        mainView.customNavigationView.channelTitleLabel.text = "#\(viewModel.chatRoomTitle)"
        
        print(viewModel.repository.fetchLatestChatData(channelID: viewModel.channelId))
        
    print(viewModel.fetchChatData())

    }
    
    func bind() {
        
        var input = ChannelChattingViewModel.Input(
            chatText:
                mainView.chatTextView.rx.text.orEmpty,
            backTap:
                mainView.customNavigationView.backButton.rx.tap,
            sendTap: mainView.sendButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        //뒤로가기
        output.backTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
            }
            .disposed(by: viewModel.disposeBag)
        
        //채팅텍스트뷰 활성화 시 플레이스홀더 숨김
        mainView.chatTextView.rx
            .didBeginEditing
            .subscribe(with: self) { owner, _ in
                
                self.mainView.placeholderLabel.isHidden = true
                
            }
            .disposed(by: viewModel.disposeBag)
        
        //텍스트버튼 활성화 (1글자 이상 일 경우)
        output.sendValidation
            .bind(to: mainView.sendButton.rx.isEnabled)
            .disposed(by: viewModel.disposeBag)
        
        output.sendValidation
            .subscribe(with: self) { owner, value in
                
                if value {
                    self.mainView.sendButton.setImage(ConstantIcon.sendActive, for: .normal)
                }
                
            }
            .disposed(by: viewModel.disposeBag)
        
        output.messageIsSent
            .subscribe(with: self) { owner, value in
                
                if value {
                    self.mainView.chatTextView.text = ""
                }
                
            }
            .disposed(by: viewModel.disposeBag)
        
        
        //채팅텍스트뷰 높이 조절
        mainView.chatTextView.rx
            .didChange
            .subscribe(with: self) { owner, _ in
                
                let size = CGSize(width: self.mainView.chatTextView.frame.width, height: .infinity)
                let estimatedSize = self.mainView.chatTextView.sizeThatFits(size)
                
                let isMaxHeight = estimatedSize.height >= 54
                
                if isMaxHeight != self.mainView.chatTextView.isScrollEnabled {
                    self.mainView.chatTextView.isScrollEnabled = isMaxHeight
                    self.mainView.chatTextView.reloadInputViews()
                    self.mainView.chatTextView.setNeedsUpdateConstraints()
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        
    }
    
    override func configureView() {
        view.backgroundColor = ConstantColor.bgSecondary
    }
    
}


extension ChannelChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.repository.fetchChatData(channelID: viewModel.channelId).count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChattingCell.identifier,
            for: indexPath) as? ChattingCell
        else { return UITableViewCell()}
        
        let data = self.viewModel.repository.fetchChatData(channelID: viewModel.channelId)[indexPath.row]
        
        cell.profileImageView.image = UIImage(systemName: "star")
        cell.messageTextView.text = data.content
        cell.userNameLabel.text = data.userData?.userName
        cell.dateLabel.text = data.createdAt.toString(of: .timeAMPM)
        
        
        return cell
        
    }
    
    
    
    
    
}
