//
//  WorkspaceAddView.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit
import SnapKit

class WorkspaceAddView: BaseView {
    
    let presentNavigationBarView = {
        let view = CustomPresentNavigationBarView()
        view.navigationTitleLable.text = "워크스페이스 생성"
        return view
    }()
    
    let writeSectionView = {
        let view = WorkspaceWriteView()
        return view
    }()
    
    override func configureView() {
        
        addSubview(presentNavigationBarView)
        addSubview(writeSectionView)
    }
    
    override func setConstraints() {
        
        presentNavigationBarView.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        writeSectionView.snp.makeConstraints { make in
            make.top.equalTo(presentNavigationBarView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    
    
}

