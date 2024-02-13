//
//  ExploreViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/6/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ExploreViewController: BaseViewController {
    
    //MARK: - UI
    
    let emptyView = {
        let view = UIView()
        view.backgroundColor = ConstantColor.bgSecondary
        return view
    }()
    
    let customNavigationView = {
        let view = CustomPresentNavigationBarView()
        view.navigationTitleLable.text = "채널 탐색"
        view.backgroundColor = ConstantColor.bgSecondary
        return view
    }()
    
    let exploreTableView = {
        let view = UITableView()
        view.register(
            HomeListCell.self,
            forCellReuseIdentifier: HomeListCell.identifier
        )
        view.rowHeight = 41
        view.separatorStyle = .none
        return view
    }()
    
    
    //MARK: - 로직
    
    let viewModel = ExploreViewModel()
    
    var workspaceID: Int? //값전달받음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        
        bind()
                
    }
    
    
    
    func bind() {
        
        guard let id = workspaceID else { return }
        
        let input = ExploreViewModel.Input(
            workspaceID: id,
            closeTap:
                self.customNavigationView
                .closeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        //닫힘 버튼 선택 시
        output.closeButtonTapped
            .subscribe(with: self) { owner, value in
                if value {
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        viewModel.exploreChannelContainer
            .subscribe(with: self) { owner, channels in
                owner.viewModel.channelList = channels
                owner.exploreTableView.reloadData()
            }
            .disposed(by: viewModel.disposeBag)
        
        
        
    }
    
    
    //MARK: - UI 레이아웃
    
    override func configureView() {
        
        view.backgroundColor = ConstantColor.bgSecondary
        view.addSubview(emptyView)
        emptyView.addSubview(customNavigationView)
        view.addSubview(exploreTableView)
        
    }
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(customNavigationView.snp.bottom)
        }
        
        customNavigationView.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        exploreTableView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        
    }
    
    
}




extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.channelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeListCell.identifier,
            for: indexPath
        ) as? HomeListCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none //선택 시 회색 되는 거 없애
        
        let channel = viewModel.channelList[indexPath.row]
        
        cell.configureChannelCell(with: channel)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = JoinChannelViewController()

        
        vc.modalPresentationStyle = .overCurrentContext
        vc.channelName = viewModel.channelList[indexPath.row].name
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.isNavigationBarHidden = true
                
    }
    
}
