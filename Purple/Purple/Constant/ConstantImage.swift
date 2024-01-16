//
//  ConstantImage.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

enum ConstantImage: String {
    
    case onboarding = "OnboardingImage"
    case launching = "LaunchingImage"
    case empty = "EmptyImage"
    case rectangleProfile = "RectangleImage"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
}
