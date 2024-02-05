//
//  AlertView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 30/01/2024.
//

import UIKit
import MakeConstraints

final class GrocerAlertView: NibUIView, AlertViewProtocol {
    // MARK: IBOutlet
    @IBOutlet weak private var stateImageContainer: UIView!
    @IBOutlet weak private var stateImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    private let backgroundVisualView = UIView()
    private var bottomLineView: UIView = UIView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func show(title: String, message: String, withState state: AlertState) {
        titleLabel.text = title
        subtitleLabel.text = message
        backgroundVisualView.backgroundColor = state.primaryColor
        bottomLineView.backgroundColor = state.primaryColor
        stateImageView.tintColor = state.primaryColor
        stateImageView.image = state.icon
    }
}

// MARK: - Configurations
private extension GrocerAlertView {
    func configureUI() {
        layer.cornerRadius = .Constants.cornerRadius
        heightAnchor.constraint(greaterThanOrEqualToConstant: 72).isActive = true
        widthConstraints(.screenBounds.width - (24 * 2))
        makeBackgroundBlur()
        addButtonLineView()
        setupStateImage()
        setupTitleLabel()
        setupSubtitleLabel()
        layer.masksToBounds = true
    }
    
    func makeBackgroundBlur() {
        backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        insertSubview(blurView, at: 0)
        blurView.fillSuperview()
        addVisualView()
    }
    
    func addVisualView() {
        backgroundVisualView.heightConstraints(30)
        backgroundVisualView.widthConstraints(60)
        insertSubview(backgroundVisualView, at: 0)
        backgroundVisualView.alpha = 0.6
        backgroundVisualView.makeConstraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 0)
        )
    }
    
    func addButtonLineView() {
        // insertSubview(bottomLineView, at: 1)
        addSubview(bottomLineView)
        bottomLineView.fillXSuperView()
        bottomLineView.heightConstraints(3)
        bottomLineView.makeConstraints(bottomAnchor: bottomAnchor)
        bottomLineView.alpha = 0.8
    }
    
    func setupStateImage() {
        stateImageContainer.backgroundColor = .grInputField.withAlphaComponent(0.3)
        stateImageContainer.layer.cornerRadius = stateImageContainer.bounds.height / 2
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .grTextPrimary
        titleLabel.font = .Large(weight: .bold)
    }
    
    func setupSubtitleLabel() {
        subtitleLabel.textColor = .grTextPrimary
        subtitleLabel.font = .medium(weight: .regular)
    }
}
