//
//  CGFloat+Constants.swift
//  Grocer
//
//  Created by Ahmed Yamany on 05/02/2024.
//

import UIKit

extension CGFloat {
    enum Constants {
        static let contentPadding: CGFloat = 24
        static let cellSpacing: CGFloat = 12
        static let cellPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static var tabBarHeight: CGFloat {
            52 + (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 32)
        }
    }
}
