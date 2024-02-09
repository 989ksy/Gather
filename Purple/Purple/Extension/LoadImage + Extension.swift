//
//  LoadImage + Extension.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/28/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(
        from url: URL,
        placeHolderImage: UIImage? = nil)
    {
        let modifier = AnyModifier { request in
            var r = request
            if let token = KeychainStorage.shared.userToken {
                
                r.setValue(
                    token,
                    forHTTPHeaderField: "Authorization")
                
                r.setValue(
                    APIKey.sesacKey,
                    forHTTPHeaderField: "SesacKey")
            }
            return r
        }
        self.kf.setImage(
            with: url,
            placeholder: placeHolderImage,
            options: [
                .requestModifier(modifier),
                .forceRefresh
            ]
        )
    }
}
