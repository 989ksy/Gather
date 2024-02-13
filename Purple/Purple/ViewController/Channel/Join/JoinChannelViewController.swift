//
//  JoinChannelViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class JoinChannelViewController: BaseViewController {
    
    //MARK: - UI
        
    let customView = {
        let view = CustomPopupView()
        view.titleLabel.text = "채널 참여"
        view.contentLabel.text = "[어쩌구] 채널에 참여하시겠습니까?"
        return view
    }()
    
    
    //MARK: - 로직
    
    //채널이름 값전달
    var channelName: String?

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ConstantColor.alphaBlack
        
        bind()
    }
    
    func bind() {
        
        //채널이름
        self.customView.contentLabel.text = "[\(channelName ?? "")] 채널에 참여하시겠습니까?"
        
        
        //취소 버튼 선택 시
        self.customView.cancelButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                print("---- 참여 취소")
                                
                self.navigationController?.popViewController(animated: true)
                
            }
            .disposed(by: disposeBag)
        
        //확인 버튼 선택 시
        self.customView.okButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                print("---- 참여")
                
                let vc = ChannelChattingViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.channelName = self.channelName
                
                self.navigationController?.pushViewController(vc, animated: true)
                                
            }
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - 레이아웃
    
    override func configureView() {
        
        view.backgroundColor = ConstantColor.alphaBlack
        view.addSubview(customView)
        
    }
    override func setConstraints() {
     
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
