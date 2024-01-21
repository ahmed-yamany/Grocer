//
//  NavigationRouter.swift
//  Grocer
//
//  Created by Ahmed Yamany on 01/1/2023.
//

import UIKit

public final class NavigationRouter: Router {
    public let navigationController: UINavigationController
        
    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
