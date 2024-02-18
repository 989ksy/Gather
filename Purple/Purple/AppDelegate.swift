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
import FirebaseMessaging

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
        
        // MARK: - 카카오
        
        //KakaoSDK 초기화 코드 추가
        KakaoSDK.initSDK(appKey: APIKey.kakaoKey)
        
        // MARK: - 파이어베이스
        
        // 파이어베이스 초기화 코드 추가
        FirebaseApp.configure()
        
        // 푸시 알림 권한 설정
        UNUserNotificationCenter.current().delegate = self
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self
        
        // 푸시 알림에 앱 등록 (푸시 권한)
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge, .providesAppNotificationSettings]) { didAllow, error in
                print("\(didAllow)")
            }
        
        application.registerForRemoteNotifications()
        
        
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


extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    // Tells the delegate that the app successfully registered with APNs.
    // APNs 토큰 사용
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print(#function)
        
        // APN 토큰을 FCM 등록토큰에 매핑
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    // Sent to the delegate when APNs cannot successfully complete the registeration process.
    // APNs 토큰 가져오기 실패했을 때 실행
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(#function)
        
    }
    
    //현재 등록 코튼 가져오기 및 저장
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let firebaseToken = fcmToken ?? "No Token"
        print("firebase token: \(firebaseToken)")
        
        UserDefaults.standard.set(firebaseToken, forKey: "firebaseToken")
        
    }
    
}

extension AppDelegate {
    
    // foreground에서 러닝 중 앱에 도착하는 notification 담당
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .list, .sound, .banner])
        
    }
    
    // 도착한 notification에 대한 user의 반응을 다룬다.
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        
//        print(#function)
//        
//    }
    
    // 도착한 notification에 대한 user의 반응을 다룬다.
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(#function)
        
           completionHandler()
        
       }
    
}
