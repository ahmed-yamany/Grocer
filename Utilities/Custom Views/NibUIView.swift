//
//  NibUIView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 05/02/2024.
//

import UIKit

class NibUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        guard let view = Bundle.main.loadNibNamed(
            String(describing: Self.self),
            owner: self,
            options: nil)?.first as? UIView else {
            fatalError("Failed to load file from nib")
        }
        addSubview(view)
        view.frame = bounds
    }
}
