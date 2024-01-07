//
//  HostingView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 06/01/2024.
//

import SwiftUI

@available(iOS 13.0, *)
public struct HostingView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIViewController
    
    public let rootController: UIViewControllerType
    public init(rootController: UIViewControllerType) {
        self.rootController = rootController
    }
    
    public func makeUIViewController(context: Context) -> UIViewControllerType {
        rootController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
