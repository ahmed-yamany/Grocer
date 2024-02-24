//
//  FilterView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 23/02/2024.
//

import SwiftUI

enum ProductFilterCases: String, Hashable, CaseIterable {
    case name = "Name"
    case price = "Price"
    case quantity = "Quantity"
}

protocol StoreFilterDelegate {
    func storeFilter(didSelect item: ProductFilterCases )
}

struct StoreFilterView: View {
    @State var selected: ProductFilterCases = .name
    
    let delegate: StoreFilterDelegate
    let router: Router
    var body: some View {
        SheetView(title: L10n.Filter.title, router: router) {
            RadioButtonGroup(
                title: \.rawValue,
                items: ProductFilterCases.allCases,
                selectedId: .init(get: {
                    selected
                }, set: {
                    self.delegate.storeFilter(didSelect: $0)
                    selected = $0
                })
            )
        }
    }
}
