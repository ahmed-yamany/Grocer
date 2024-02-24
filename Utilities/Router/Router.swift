//
//  Router.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//

import UIKit
import MakeConstraints

public final class Router {
    public let navigationController: UINavigationController
    private let alertRouter: AlertRouter
    
    public required init(navigationController: UINavigationController, alertRouter: AlertRouter) {
        self.navigationController = navigationController
        self.alertRouter = alertRouter
        navigationController.navigationBar.backIndicatorImage = .iconBack
        navigationController.navigationBar.backIndicatorTransitionMaskImage = .iconBack
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func presentFullScreen(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func presentOverFullScreen(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.view.backgroundColor = .clear
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated, completion: completion)
        } else {
            navigationController.popViewController(animated: animated)
            completion()
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        viewController.navigationItem.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: animated)
        completion()
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popToViewController(viewController, animated: animated)
        completion()
    }
    
    func popToRoot(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popToRootViewController(animated: animated)
        completion()
    }
    
    func presentAlert(title: String = "", message: String, withState state: AlertState) {
        alertRouter.present(
            in: navigationController.view,
            title: title,
            message: message,
            withState: state
        )
    }
    
    func dismissAlert() {
        alertRouter.dismiss()
    }
}
