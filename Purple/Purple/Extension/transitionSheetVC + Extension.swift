//
//  TransitionVC + Extension.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/5/24.
//

import UIKit

extension UIViewController: UISheetPresentationControllerDelegate {
    

    func transitionLargeSheetVC(_ vc: UIViewController){
        
        let vc = vc
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func transitionCustomSheetVC(_ vc: UIViewController) {
        
        let vc = vc
        vc.modalPresentationStyle = .pageSheet
        
        let customDetentId = UISheetPresentationController.Detent.Identifier("custom")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customDetentId) { context in
            return 279
        }
        self.sheetPresentationController?.detents = [customDetent]
        
        if let sheet = vc.sheetPresentationController {
            //지원할 크기 지정
            sheet.detents = [customDetent]
            //크기 변하는거 감지
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func transitionVCFull(_ vc: UIViewController) {
        
        let vc = vc
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    func dismissSheetVC() {
        self.dismiss(animated: true)
    }
    
    
    
}
