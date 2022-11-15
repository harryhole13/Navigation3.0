//
//  SceneDelegate.swift
//  Navigation3.0
//
//  Created by Алексей Потемин on 26.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let myWindowScene = (scene as? UIWindowScene) else { return }
        
        let tabbar = UITabBarController()
        let feed = UINavigationController(rootViewController: FeedViewController())
        let VC = LogInViewController()
        let inspector = LoginInspector()
        VC.loginDelegate = inspector

        
        let profile = UINavigationController(rootViewController: VC)
        
        
        
        tabbar.setViewControllers([feed, profile], animated: true)
        tabbar.tabBar.backgroundColor = .white
        feed.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        
        window = UIWindow(windowScene: myWindowScene)
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        }

}

