//
//  Category.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/01/2024.
//

import Foundation

struct Category: Codable {
    let name: String
}

extension Category {
    static var samples: [Category] {
        [
            .init(name: "Food"),
            .init(name: "juice"),
            .init(name: "clothes")
        ]
    }
}

extension Category: CustomStringConvertible {
    var description: String {
        name
    }
}
