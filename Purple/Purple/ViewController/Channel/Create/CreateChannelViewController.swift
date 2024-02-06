//
//  CreateChannelViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/5/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CreateChannelViewController: BaseViewController {
    
    
    //MARK: - UI
    
    let customNavigationbarView = {
        let view = CustomPresentNavigationBarView()
        view.navigationTitleLable.text = "채널 생성"
        return view
    }()
    
    //채널이름
    let channelTitleLabel = {
        let label = commonTitleLabel()
        label.text = "채널 이름"
        return label
    }()
    let channelTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.channelName.rawValue
        return field
    }()
    
    //채널설명
    let channelDescriotionTitleLabel = {
        let label = commonTitleLabel()
        label.text = "채널 설명"
        return label
    }()
    let channelDescriotionTextField = {
        let field = commonTextField()
        field.placeholder = PlaceholderText.channelDescription.rawValue
        return field
    }()

    //생성하기 버튼
    let createButton = {
        let btn = NextButton()
        btn.setTitle("생성", for: .normal)
        return btn
    }()
    
    //MARK: - 로직
    
    let viewModel = CreateChannelViewModel()
    let disposeBag = DisposeBag()
    
    var workspaceID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    
    func bind() {
            
        let input = CreateChannelViewModel.Input(
            workspaceID: 
                workspaceID!,
            channelName:
                channelTextField.rx.text.orEmpty,
            channelDescription: channelDescriotionTextField.rx.text.orEmpty,
            createTap: createButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
                
        //채널이름 입력 시 버튼 활성화
        output.tapValidation
            .bind(to: createButton.rx.isEnabled)
            .disposed(by: disposeBag)
                
        output.tapValidation
            .subscribe(with: self) { owner, value in
                                
                owner.createButton.backgroundColor = value ? .brandPurple : .brandInactive
                
            }
            .disposed(by: disposeBag)
        
        //채널생성
        //성공 시 홈화면 전환 + 토스트 메세지
        output.isCreated
            .subscribe(with: self) { owner, value in
                
                if value {
                    
                    self.dismissSheetVC()

                    self.setToastAlert(
                        message: ToastMessage.createChannel.complecated.rawValue
                    )
                    

                    NotificationCenter.default.post(
                        name: NSNotification.Name("channelListUpdate"),
                        object: nil
                    )
                    
                    
                }
            }
            .disposed(by: disposeBag)
        
        
        //채널이름중복 시 얼럿
        output.isNameDuplicated
            .asDriver()
            .drive(with: self) { owner, value in
                
                if value {
                    
                    self.setToastAlert(
                        message: ToastMessage.createChannel.nameDuplication.rawValue
                    )
                }
                
            }
            .disposed(by: disposeBag)
        
        
        
        
    }
    
    
    
    //MARK: - UI 레이아웃
    override func configureView() {
        super.configureView()
        
        view.addSubview(customNavigationbarView)
        view.addSubview(channelTitleLabel)
        view.addSubview(channelTextField)
        view.addSubview(channelDescriotionTitleLabel)
        view.addSubview(channelDescriotionTextField)
        view.addSubview(createButton)
        
    }
    
    override func setConstraints() {
        
        customNavigationbarView.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        channelTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(customNavigationbarView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        channelTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(channelTitleLabel.snp.bottom).offset(8)
        }
        
        channelDescriotionTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(channelTextField.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        channelDescriotionTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.top.equalTo(channelDescriotionTitleLabel.snp.bottom).offset(8)
        }
    
        
        //생성하기
        createButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(45)
        }
        
        
        
    }
    
    
    
    
    
}
