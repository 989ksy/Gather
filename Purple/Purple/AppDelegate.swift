//
//  AppDelegate.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import SideMenu
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    //카카오톡에서 프로젝트 앱으로 돌아왔을때 로그인 처리를 완료하기 위해
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }
            return false
        }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //KakaoSDK 초기화 코드 추가
        KakaoSDK.initSDK(appKey: APIKey.kakaoKey)
        
        //파이어베이스 초기화 코드 추가
        FirebaseApp.configure()
        
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

