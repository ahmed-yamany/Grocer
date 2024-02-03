//
//  Array.swift
//  Grocer
//
//  Created by Ahmed Yamany on 26/01/2024.
//

import UIKit

extension Array where Element == UIImage {
    func pngData() -> [Data] {
        // swiftlint: disable force_unwrapping
        map { $0.pngData() }.filter { $0 != nil }.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}

extension Array where Element == Data {
    func  toUIImages() -> [UIImage] {
        // swiftlint: disable force_unwrapping
        map { UIImage(data: $0) }.filter { $0 != nil }.map { $0! }
        // swiftlint: enable force_unwrapping
    }
}
