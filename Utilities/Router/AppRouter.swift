//
//  AppRouter.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//

import UIKit
import SwiftUI
import Combine

final class AppRouter: Router {
    public static let shared = AppRouter()
    
    var window: UIWindow?
    var parentViewController: UIViewController?
    
    private init() { }
    
    func makeWindow(from windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.present(UIHostingController(rootView: Text("Welcome ")))
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard let window else {
            debugPrint("App Router Window is nil")
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
    }
}
