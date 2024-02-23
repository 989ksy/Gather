//
//  SceneDelegate.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/3/24.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    //iOS13이상 카카오로그인
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
           if let url = URLContexts.first?.url {
               if (AuthApi.isKakaoTalkLoginUrl(url)) {
                   _ = AuthController.handleOpenUrl(url: url)
               }
           }
       }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = OnboardingViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    // 앱이 포그라운드로 돌아왔을 때 실행
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        SocketIOManager.shared.isOpen = true
        
        NotificationCenter.default.post(
            name: NSNotification.Name("reconnectSocket"),
            object: nil
        )
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        
    }

    // 앱이 백그라운드로 나갔을 때 실행
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        print("-----------------", #function)
        
        SocketIOManager.shared.isOpen = false
        SocketIOManager.shared.closeConnection()
        
        
    }


}

