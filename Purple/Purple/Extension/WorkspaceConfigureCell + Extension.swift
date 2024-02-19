//
//  WorkspaceConfigureCell + Extension.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/5/24.
//

import UIKit

extension HomeDefaultViewController {
    
    //채널 마지막 셀("채널 추가") 구성
    func configureChannelLastCell(cell: HomeListCell) {
        cell.chanelListView.titleLabel.text = "채널 추가"
        cell.chanelListView.iconImageView.image = ConstantIcon.plusCustom
    }
    
    // 채널 셀 구성
    func configureChannelCell(cell: HomeListCell, index: Int) {
        let channel = channelList[index]
        cell.chanelListView.titleLabel.text = channel.name
        cell.chanelListView.iconImageView.image = ConstantIcon.hashThin
    }
    
    //채널 리스트
    func configureChannelCell(cell: HomeListCell, indexPath: IndexPath) {
        switch indexPath.row {
        case channelList.count: // 3
            configureChannelLastCell(cell: cell)
        default:
            configureChannelCell(cell: cell, index: indexPath.row)
        }
    }
    
    
    //MARK: - 셀 선택 시 액션시트
    
    func presentActionSheet(titleCreate: String, titleExplore: String, workspaceID: Int) {
        
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        //채널생성 화면 띄움
        let createChannel = UIAlertAction(title: titleCreate, style: .default) { _ in
            
            let vc = CreateChannelViewController()
            vc.workspaceID = workspaceID //아이디 넘겨
            
            self.transitionLargeSheetVC(vc)
            
                        
        }
        
        //채널탐색 화면 띄움
        let exploreChannel = UIAlertAction(title: titleExplore, style: .default) { _ in
            
            let vc = ExploreViewController()
            
            vc.modalPresentationStyle = .fullScreen
            
            vc.workspaceID = workspaceID //아이디 넘겨
                        
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.isNavigationBarHidden = true
            
        }
        
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(createChannel)
        alert.addAction(exploreChannel)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
        
    }
    
    
    
}
