//
//  OnboardingRouter.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//
import UIKit

class ModalRouter: Router {
    public var parentViewController: UIViewController?
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        guard parentViewController != nil else {
            debugPrint("Modal Router parentViewController is nil")
            parentViewController = viewController
            return
        }
        viewController.modalPresentationStyle = .fullScreen
        parentViewController?.topMostViewController().present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        parentViewController?.topMostViewController().dismiss(animated: animated, completion: completion)
    }
}
