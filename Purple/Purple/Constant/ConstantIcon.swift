//
//  ConstantIcon.swift
//  Buzz
//
//  Created by Seungyeon Kim on 1/2/24.
//

import UIKit

struct ConstantIcon {
    
    //MARK: - TabItem Active
    
    static let homeActive = UIImage(named: "PropertyHomeActive")
    static let messageActive = UIImage(named: "PropertyMessageActive")
    static let profileActive = UIImage(named: "PropertyProfileActive")
    static let settingActive = UIImage(named: "PropertySettingActive")

    //MARK: - TabItem Inactive
    
    static let homeCustom = UIImage(named: "PropertyHome")
    static let messageCustom = UIImage(named: "PropertyMessage")
    static let profile = UIImage(named: "PropertyProfile")
    static let setting = UIImage(named: "PropertySetting")
    
    //MARK: - Buttons
    
    static let newMessageButton = UIImage(named: "NewMessageButton")
    static let appleButton = UIImage(named: "AppleIDLogin")
    static let kakaoButton = UIImage(named: "KakaoLogin")
    
    //MARK: - Camera
    
    static let cameraCustom = UIImage(named: "PropertyCamera")
    
    //MARK: - WorkSpace
    
    static let workspace = UIImage(named: "PropertyWorkspace")
    
    //MARK: - List
    
    static let listCustom = UIImage(named: "PropertyList")
    
    //MARK: - chevron
    
    static let chevronUp = UIImage(named: "PropertyChevronUp")
    static let chevronLeft = UIImage(named: "PropertyChevronLeft")
    static let chevronDown = UIImage(named: "PropertyChevronDown")
    static let chevronRight = UIImage(named: "PropertyChevronRight")
    
    //MARK: - Hash
    
    static let hashThick = UIImage(named: "PropertyHashThick")
    static let hashThin = UIImage(named: "PropertyHashThin")
    
    //MARK: - PropertyIcon
    
    static let close = UIImage(named: "PropertyClose")
    static let threeDots = UIImage(named: "PropertyThreeDots")
    static let plusCustom = UIImage(named: "PropertyPlus")
    static let helpCustom = UIImage(named: "PropertyHelp")
    static let emailCustom = UIImage(named: "PropertyEmail")
    static let sendInactive = UIImage(named: "PropertySendInactive")
    static let sendActive = UIImage(named: "PropertySendActive")?.withTintColor(ConstantColor.purpleBrand ?? .purple)
    
    
    //MARK: - Profile
    
    static let dummy = UIImage(named: "Dummy")
    static let noPhotoA = UIImage(named: "NoPhotoA")
    static let noPhotoB = UIImage(named: "NoPhotoB")
    static let noPhotoC = UIImage(named: "NoPhotoC")
    static let searchBot = UIImage(named: "")
    
}
