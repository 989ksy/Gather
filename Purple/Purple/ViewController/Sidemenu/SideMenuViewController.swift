//
//  SideMenuViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/17/24.
//

import UIKit
import SideMenu

final class SideMenuViewController: BaseViewController {
    
    let dummyList: [Dummy] = [
        Dummy(title: "Team KIA 타이거스", date: "24.01.02", thum: UIImage(named: "Kia")!),
        Dummy(title: "동물의 숲", date: "24.01.20", thum: UIImage(named: "animalCrossing")!),
        Dummy(title: "짱구는 못말려", date: "24.02.12", thum: UIImage(named: "Zzangu")!),
        Dummy(title: "맨체스터 유나이티드 팬클럽", date: "24.01.02", thum: UIImage(named: "Manchester")!),
        Dummy(title: "농사 꿀팁", date: "24.02.16", thum: UIImage(named: "Potato")!),
        Dummy(title: "영화광", date: "24.02.20", thum: UIImage(named:  "Movie")!),
    ]

    let mainView = SideMenuView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ConstantColor.bgSecondary
        
        mainView.sideMenuTableView.dataSource = self
        mainView.sideMenuTableView.delegate = self
        
        
    }
    
    
    
    
}


extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dummyList.count == 0 {
            self.mainView.noDataView.isHidden = false
        } else {
            self.mainView.noDataView.isHidden = true
        }
        
        print("-----", dummyList.count)
        
        return dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell else {return UITableViewCell()}
                                
        let data = dummyList[indexPath.row]

        cell.dateLabel.text = data.date
        cell.titleLabel.text = data.title
        cell.thumImageView.image = data.thum
        
        cell.selectionStyle = .none //선택 시 회색 되는 거 없애
        
        if indexPath.row != 0 {
            cell.threeDotsButton.isHidden = true
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
