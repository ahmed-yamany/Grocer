//
//  AddProductViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

final class AddProductViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var quantity: String = ""
    @Published var price: String = ""
    @Published var category: String = ""
    @Published var unit: String = ""
    @Published var barcode: String = ""
    @Published var images: [UIImage] = []
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    public func startBarCodeScanner() {
        let controller = BarCodeScannerViewController(router: router, delegate: self)
        router.present(controller)
    }
}

extension AddProductViewModel: BarCodeScannerDelegate {
    func scanned(_ barcode: String) {
        self.barcode = barcode
    }
}
