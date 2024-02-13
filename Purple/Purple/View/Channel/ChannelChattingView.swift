//
//  ChannelChattingView.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import SnapKit

final class ChannelChattingView: BaseView {
    
    //MARK: - 네비게이션 영역
    
    let emptyView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.bgSecondary
        return view
    }()
    
    let customNavigationView = {
        let view = ChannelNavigationBarView()
        return view
    }()
    
    //MARK: - 채팅영역
    
    let chattingTableView = {
        let view = UITableView()
        view.register(
            ChattingCell.self,
            forCellReuseIdentifier:
                ChattingCell.identifier
        )
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    //MARK: - 입력영역
    
    let chatBackView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.bgPrimary
        view.layer.cornerRadius = 8
        return view
    }()
    
    let chatTextView = { //LH 18
        let view = UITextView()
        view.backgroundColor = ConstantColor.bgPrimary
        view.textColor = ConstantColor.txtPrimary
        view.font = ConstantTypo.body
//        view.text = "메세지를 입력하세요오"
        
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let placeholderLabel = {
        let label = UILabel()
        label.textColor = ConstantColor.txtPrimary
        label.font = ConstantTypo.body
        label.text = "메세지를 입력하세요"
        return label
    }()
    
    let addButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.plusCustom, for: .normal)
        return btn
    }()
    
    let sendButton = {
        let btn = UIButton()
        btn.setImage(ConstantIcon.sendInactive, for: .normal)
        return btn
    }()
    
    
    override func configureView() {
        
        backgroundColor = ConstantColor.bgSecondary
        
        addSubview(emptyView)
        addSubview(customNavigationView)
        addSubview(chattingTableView)
        addSubview(chatBackView)
        chatBackView.addSubview(addButton)
        chatBackView.addSubview(chatTextView)
        chatTextView.addSubview(placeholderLabel)
        chatBackView.addSubview(sendButton)
        
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
            
        customNavigationView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(54)
            make.horizontalEdges.equalToSuperview()
        }
        
        chattingTableView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        chatBackView.snp.makeConstraints { make in
            make.top.equalTo(chattingTableView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(12)
            make.height.equalTo(chatTextView.snp.height).offset(14)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(22)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        chatTextView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(54) //54
            make.width.equalTo(275)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(7) //
            make.bottom.equalToSuperview().inset(7)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalTo(addButton)
        }
        
        
        
    }
    
    
}
