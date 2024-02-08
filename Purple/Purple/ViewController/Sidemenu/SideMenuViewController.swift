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
        Dummy(title: "KiaTigers", date: "24.01.02", thum: UIImage(systemName: "star")!),
        Dummy(title: "HanhwaEgles", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "SamsungLions", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "LGTwins", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "DoosanBears", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "KiumHeroes", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "KTWiz", date: "24.01.02", thum: UIImage(systemName:  "star")!),
        Dummy(title: "LotteGiants", date: "24.01.02", thum: UIImage(systemName:  "star")!)
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
        print("\(data.date)")
        cell.titleLabel.text = data.title
        print("\(data.title)")
//        cell.thumImageView.image = data.thum
        
        cell.selectionStyle = .none //선택 시 회색 되는 거 없애

        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
