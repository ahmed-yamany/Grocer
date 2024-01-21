//
//  Router.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//

import UIKit

/// Protocol definition for a Router, which is an AnyObject (class) protocol
public protocol Router: AnyObject {
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController)        
}

public extension Router {
    func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    func presentFullScreen(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void = {}) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.pushViewController(viewController, animated: animated)
        completion()
    }
    
    func pop(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.popViewController(animated: animated)
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
}
