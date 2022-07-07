//
//  SceneDelegate.swift
//  小粉书
//
//  Created by zhaitong on 2022/7/6.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.frame = windowScene.coordinateSpace.bounds
        window?.backgroundColor = .white
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.tintColor = UIColor(named: kMainColor)
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "首页",
            image: UIImage(systemName: "house.fill"),
            selectedImage: nil)
        //商城
        let storeVC = StoreViewController()
        storeVC.tabBarItem = UITabBarItem(
            title: "商城",
            image: UIImage(systemName: "cart.fill"),
            selectedImage: nil)
        //发布
        let noteVC = NoteViewController()
        noteVC.tabBarItem = UITabBarItem(
            title: "发布",
            image: UIImage(systemName: "plus.rectangle.fill"),
            selectedImage: nil)
        //消息
        let messageVC = MessageViewController()
        messageVC.tabBarItem = UITabBarItem(
            title: "消息",
            image: UIImage(systemName: "message.fill"),
            selectedImage: nil)
        //我的
        let mineVC = MineViewController()
        mineVC.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil)
        tabBarVC.viewControllers = [homeVC, storeVC, noteVC, messageVC, mineVC]
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

