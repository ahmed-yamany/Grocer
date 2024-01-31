//
//  AlertState.swift
//  Grocer
//
//  Created by Ahmed Yamany on 31/01/2024.
//

import UIKit

public enum AlertState: CaseIterable {
    case error, warning, success
    
    var primaryColor: UIColor {
        switch self {
            case .error: UIColor.systemRed
            case .warning: UIColor.systemOrange
            case .success: UIColor.grOtherSecondaryToPrimary
        }
    }
    
    var icon: UIImage? {
        switch self {
            case .error: UIImage(systemName: "x.circle.fill")
            case .warning: UIImage(systemName: "exclamationmark.circle.fill")
            case .success: UIImage(systemName: "checkmark.circle.fill")
        }
    }
}
