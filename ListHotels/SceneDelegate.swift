//
//  SceneDelegate.swift
//  ListHotels
//
//  Created by Байсангур on 23.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = ListHotelsVC()
        window?.makeKeyAndVisible()
    }


}

