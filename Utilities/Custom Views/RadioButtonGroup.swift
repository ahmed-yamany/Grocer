//
//  RadioButtonGroup.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/02/2024.
//

import SwiftUI

struct RadioButtonGroup<Item: Equatable & Hashable>: View {
    let title: KeyPath<Item, String>
    let items: [Item]
    @Binding var selectedId: Item
        
    var body: some View {
        VStack {
            ForEach(items, id: \.self) { item in
                RadioButton(title: item[keyPath: title], item: item, selectedItem: $selectedId)
            }
        }
    }
}

struct RadioButton<Item: Equatable>: View {
    let title: String
    
    let item: Item
    @Binding var selectedItem: Item
    
    var body: some View {
        HStack {
            Toggle(title, isOn: .init(get: {
                return self.selectedItem == self.item ? true : false
            }, set: { new in
                if new {
                    selectedItem = item
                }
            }))
        }
    }
}
