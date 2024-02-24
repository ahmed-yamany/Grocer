//
//  StringConvertible.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/02/2024.
//

import Foundation

protocol StringConvertible: Equatable {
    var stringValue: String { get }
}

extension String: StringConvertible {
    var stringValue: String { return self }
}

extension Optional: StringConvertible where Wrapped == String {
    var stringValue: String { return self ?? "" }
}
