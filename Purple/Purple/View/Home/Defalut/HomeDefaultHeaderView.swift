//
//  HomeDefaultHeaderView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/19/24.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTouchSection(_ sectionIndex: Int)
}

final class HomeDefaultHeaderView: UITableViewHeaderFooterView {
    
    //섹션 방향 이미지 변경
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.foldImageView.image = ConstantIcon.chevronDown
                self.dividerBottom.isHidden = true
            }
            
            else {
                self.foldImageView.image = ConstantIcon.chevronUp;
            }
        }
    }
    
    //섹션 인덱스
    var delegate: HeaderViewDelegate?
    
    let tapGestureRecofnizer = UITapGestureRecognizer()
    var sectionIndex = 0 //섹션값 저장할 거임
    
    //MARK: - UI
    
    let layerView = {
        let view = UIView()
        return view
    }()
    
    let dividerUp = {
        let view = Divider()
        return view
    }()
    
    let dividerBottom = {
        let view = Divider()
        return view
    }()
    
    let dividerAdd = {
        let view = Divider()
        return view
    }()
    
    let addMemberButtonView = {
        let view = HomeListView()
        view.iconImageView.image = nil
        view.titleLabel.text = nil
        return view
    }()
    
    let sectionTitleLabel = {
        let label = UILabel()
        label.text = "섹션 테스트"
        label.font = ConstantTypo.title2
        label.textColor = UIColor.brandBlack
        return label
    }()
    
    let foldImageView = {
        let view = UIImageView()
        view.image = ConstantIcon.chevronDown
        return view
    }()
    
    static let identifier = "HomeDefaultHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        sectionTitleLabel.isHidden = true
        addMemberButtonView.isHidden = true
        
        self.configureView()
        self.setConstraints()
        
        layerView.addGestureRecognizer(tapGestureRecofnizer)
        tapGestureRecofnizer
            .addTarget(self, action: #selector(didSelectSection))
        
        
    }
    
    @objc
    func didSelectSection() {
        
        print(self.sectionIndex)
        
        delegate?.didTouchSection(self.sectionIndex)
        isOpened.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        addSubview(layerView)
        layerView.addSubview(dividerUp)
        layerView.addSubview(dividerBottom)
        layerView.addSubview(sectionTitleLabel)
        layerView.addSubview(foldImageView)
        addSubview(addMemberButtonView)
        addSubview(dividerAdd)
        
    }
    
    func setConstraints() {
        
        layerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dividerBottom.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        foldImageView.snp.makeConstraints { make in
            make.width.equalTo(26.8)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(sectionTitleLabel)
        }
        
        addMemberButtonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()//
        }
        
        dividerAdd.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(addMemberButtonView.snp.top)
        }
        
    }
    
}
