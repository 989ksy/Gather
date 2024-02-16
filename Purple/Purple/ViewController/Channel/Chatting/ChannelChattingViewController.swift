//
//  ChannelChattingViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ChannelChattingViewController: BaseViewController {
        
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
        
        mainView.customNavigationView.countLabel.text = "3"
        
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
        //버튼 색상 변경
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
        
        //메세지 잘 보내짐
        //텍스트뷰 초기화 + 테이블 reload
        output.messageIsSent
            .subscribe(with: self) { owner, value in
                
                if value {
                    self.mainView.chatTextView.text = ""
                    
                    self.mainView.chattingTableView.reloadData()
                    
                }
                
            }
            .disposed(by: viewModel.disposeBag)
        
        //새로 채팅 보냈을 때
        
        viewModel.updatedCahtData
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, result in
                self.viewModel.readChatData.append(result)
                self.mainView.chattingTableView.reloadData()
                
                
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
