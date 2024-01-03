//
//  BaseTableViewCell.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        func configureView() {}
        func setConstraints() {}
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {}
    func setConstraints() {}
    
}
