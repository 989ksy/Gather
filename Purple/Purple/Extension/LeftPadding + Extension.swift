//
//  LeftPadding + Extension.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 14, y: 14, width: 12, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
