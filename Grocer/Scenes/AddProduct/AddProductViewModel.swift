//
//  AddProductViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

class AddProductViewModel: ObservableObject {
    @Published var productName: String = ""
    @Published var productQuantity: Int = 0
    @Published var productPrice: Double = 0.0
}
