//
//  ToastMessage.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/10/24.
//

import UIKit
import Toast

extension UIViewController {
        
    func setToastAlert(message: String) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.backgroundColor = ConstantColor.purpleBrand!
            style.messageColor = ConstantColor.whiteBrand!
            style.messageFont = ConstantTypo.body
            style.messageAlignment = .center
            self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
        }
    }
    
}
