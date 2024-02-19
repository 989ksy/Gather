//
//  ChannelSettingSecondSectionCell.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/19/24.
//

import UIKit
import SnapKit


final class ChannelSettingSecondSectionCell: BaseTableViewCell {
    
    static let identifier = "ChannelSettingSecondSectionCell"
    
    let kiaList: [KiaPlayers] = [
        KiaPlayers(name: "이범호", profile: UIImage(named: "1_71")!),
        KiaPlayers(name: "윤영철", profile: UIImage(named: "2_13")!),
        KiaPlayers(name: "이의리", profile: UIImage(named: "3_48")!),
        KiaPlayers(name: "양현종", profile: UIImage(named: "4_54")!),
        KiaPlayers(name: "정해영", profile: UIImage(named: "6_62")!),
        KiaPlayers(name: "박찬호", profile: UIImage(named: "7_1")!),
        KiaPlayers(name: "김선빈", profile: UIImage(named: "8_3")!),
        KiaPlayers(name: "김도영", profile: UIImage(named: "9_5")!),
        KiaPlayers(name: "변우혁", profile: UIImage(named: "10_29")!),
        KiaPlayers(name: "최원준", profile: UIImage(named: "11_16")!),
        KiaPlayers(name: "선동열", profile: UIImage(named: "12_18")!),
        KiaPlayers(name: "이우성", profile: UIImage(named: "13_25")!),
        KiaPlayers(name: "이종범", profile: UIImage(named: "14_7")!),
        KiaPlayers(name: "최지민", profile: UIImage(named: "17_jm")!),
        KiaPlayers(name: "나성범", profile: UIImage(named: "15_나성범")!),
        KiaPlayers(name: "최형우", profile: UIImage(named: "16_choi")!),
        KiaPlayers(name: "소크라테스", profile: UIImage(named: "18_sc")!),

    ]
    
    let memberCollecitonView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
        view.register(ChannelMemberCollectionViewCell.self, forCellWithReuseIdentifier: ChannelMemberCollectionViewCell.identifier)
        view.backgroundColor = ConstantColor.bgPrimary
        return view
        
    }()
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

            let spacing: CGFloat = 15  // 여백
            let totalSpacing = (spacing * 4) // 총 여백 (셀 사이의 간격 4개)
            let numberOfItemsPerRow: CGFloat = 5  // 한 줄에 표시할 아이템 수

            // 사용 가능한 전체 너비 계산 (화면 너비에서 좌우 여백을 뺀 값)
            let availableWidth = UIScreen.main.bounds.width - totalSpacing - (spacing * 2) // 좌우 여백도 고려

            // 각 셀의 너비 계산
            let widthPerItem = availableWidth / numberOfItemsPerRow

            // 셀 크기 설정
            layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem) // 셀의 높이도 조절할 수 있음

            // 섹션 내부 여백 설정
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

            // 셀 사이의 최소 간격 설정
            layout.minimumInteritemSpacing = 7  // 아이템 사이 간격 (상하간격)
            layout.minimumLineSpacing = spacing  // 줄 사이 간격

            return layout
    }

    
    override func configureView() {
        
        contentView.addSubview(memberCollecitonView)
        
        memberCollecitonView.delegate = self
        memberCollecitonView.dataSource = self
        
        backgroundColor = ConstantColor.bgPrimary

        
    }
    
    override func setConstraints() {
        
        memberCollecitonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
}


extension ChannelSettingSecondSectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return kiaList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelMemberCollectionViewCell.identifier, for: indexPath) as? ChannelMemberCollectionViewCell else { return UICollectionViewCell() }
        
        let data = kiaList[indexPath.item]
        
        cell.profileImageView.image = data.profile
        cell.userNameLabel.text = data.name
        
        return cell
        
    }
    
    
    
    
    
}
