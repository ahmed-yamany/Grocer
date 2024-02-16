//
//  BarCodeField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/01/2024.
//

import SwiftUI

struct BarCodeField: View {
    @Binding var barcode: String
    let router: Router
    
    var body: some View {
        PrimaryTextField(title: L10n.Field.barCode, text: $barcode, fieldView: {
            HStack {
                TextField("", text: $barcode)
                
                Button {
                    startBarCodeScanner()
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.custom(size: 20, weight: .semibold))
                }
            }
        })
        .keyboardType(.numberPad)
    }
    
    public func startBarCodeScanner() {
        let coordinator = Coordinator(parent: self)
        let controller = BarCodeScannerViewController(router: router, delegate: coordinator)
        router.present(controller)
        Logger.log("start bar code scanner", category: \.default, level: .fault)
    }
    
    class Coordinator: BarCodeScannerDelegate {
        
        let parent: BarCodeField
        init(parent: BarCodeField) {
            self.parent = parent
        }
        
        func scanned(_ barcode: String) {
            Logger.log("scanned barcode \(barcode)", category: \.default, level: .fault)
            parent.barcode = barcode
        }
    }
}
