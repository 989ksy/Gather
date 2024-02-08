//
//  ConstantColor.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

struct ConstantColor {
    
    //MARK: - Brand
    
    static let purpleBrand = UIColor(named: "BrandPurple")
    static let errorBrand = UIColor(named: "BrandError")
    static let inActiveBrand = UIColor(named: "BrandInactive")
    static let blackBrand = UIColor(named: "BrandBlack")
    static let grayBrand = UIColor(named: "BrandGray")
    static let whiteBrand = UIColor(named: "BrandWhite")
    
    //MARK: - Text
    
    static let txtPrimary = UIColor(named: "TextPrimary")
    static let txtSecondary = UIColor(named: "TextSecondary")
    
    //MARK: - Background
    
    static let bgPrimary = UIColor(named: "BackgroundPrimary")
    static let bgSecondary = UIColor(named: "BackgroundSecondary")
    
    //MARK: - View
    
    static let seperator = UIColor(named: "ViewSeperator")
    static let alphaBlack = UIColor.brandBlack.withAlphaComponent(0.5)    
}
