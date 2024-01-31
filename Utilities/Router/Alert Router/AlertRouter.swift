//
//  AlertRouter.swift
//  Grocer
//
//  Created by Ahmed Yamany on 31/01/2024.
//

import UIKit
import MakeConstraints

public protocol AlertViewProtocol: AnyObject {
    func show(title: String, message: String, withState state: AlertState)
}

public class AlertRouter {
    private var anchorConstraints: AnchoredConstraints?
    public var superview: UIView?
    public var alertView: UIView & AlertViewProtocol
    
    init(alertView: UIView & AlertViewProtocol) {
        self.alertView = alertView
    }
    
    public func present(in view: UIView, title: String, message: String, withState state: AlertState) {
        self.alertView.show(title: title, message: message, withState: state)
        guard superview == nil else { return }
        present(in: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss()
        }
    }
    
    public func dismiss(_ completion: @escaping () -> Void = {}) {
        if let superview {
            anchorConstraints?.top?.constant = -superview.safeAreaInsets.top * 3
            animate(superview) {
                self.alertView.removeFromSuperview()
                completion()
            }
        }
        anchorConstraints = nil
        superview = nil
    }
    
    private func present(in view: UIView) {
        view.addSubview(alertView)
        superview = view
        layoutAlertView(in: view)
    }
    
    private func layoutAlertView(in view: UIView) {
        UIView.animate(withDuration: 0) { [unowned self] in
            alertView.centerXInSuperview()
            view.layoutIfNeeded()
        } completion: {[unowned self] _ in
            anchorConstraints = alertView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
            animate(view)
        }
    }
    
    private func animate(_ view: UIView, completion: @escaping () -> Void = {}) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2) {
            view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
