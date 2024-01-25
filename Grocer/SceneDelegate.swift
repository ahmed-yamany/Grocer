//
//  SceneDelegate.swift
//  Grocer
//
//  Created by Ahmed Yamany on 06/01/2024.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        AppRouter.shared.makeWindow(from: windowScene)
        CoreDataManager.shared.loadPersistentStore()
    }
}
