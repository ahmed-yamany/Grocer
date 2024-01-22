//
//  AppRouter.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//

import UIKit
import SwiftUI
import Combine
// TODO: - Convert App Router to Coordinator
final class AppRouter {
    public static let shared = AppRouter()
    
    var window: UIWindow?
    
    private init() { }
    
    func makeWindow(from windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        self.present(UIHostingController(rootView: TabBarView()))
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard let window else {
            debugPrint("App Router Window is nil")
            return
        }
        window.rootViewController = viewController
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
    }
}
