//
//  Product.swift
//  Grocer
//
//  Created by Ahmed Yamany on 02/02/2024.
//

import UIKit

extension Product {
    var priceString: String {
        String(format: "%.1f", price)
    }
    
    var quantityString: String {
        String(quantity)
    }
}

extension Product {
    func firstImage() -> UIImage {
        guard let image = images?.toUIImages().first as? UIImage else {
            return UIImage()
        }
        
        return image
    }
}
