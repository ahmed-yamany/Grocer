//
//  Products.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/01/2024.
//

import UIKit

struct Product: Codable {
    var name: String
    var quantity: Int
    var price: Double
    var category: Category
    var unit: String
    var barcode: String
    var imagesData: [Data]
    
    var images: [UIImage] {
        imagesData.map { UIImage(data: $0) ?? UIImage() }
    }
}
