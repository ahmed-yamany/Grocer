//
//  AddProductView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct AddProductView: View {
    let router: Router
    @StateObject private var viewModel = AddProductViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                nameField
                HStack(spacing: 12) {
                    quantityField
                    priceField
                }
                HStack(spacing: 12) {
                    categoryField
                    unitField
                }
                barcodeField
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbarTitle("Add Product")
        .onAppear {
//            TabBarViewModel.shared.tabBarIsHidden = true
        }
    }
    
    private var nameField: some View {
        PrimaryTextField(title: "Name", text: $viewModel.productName) {
            TextField("", text: $viewModel.productName)
        }
        .keyboardType(.default)
    }
    
    private var quantityField: some View {
        PrimaryTextField(title: "Quantity", text: $viewModel.productName, fieldView: {
            TextField("", text: $viewModel.productName)
        })
        .keyboardType(.numberPad)
    }
    
    private var priceField: some View {
        PrimaryTextField(title: "Price", text: $viewModel.productName, fieldView: {
            TextField("", text: $viewModel.productName)
        })
        .keyboardType(.decimalPad)
    }
    
    private var categoryField: some View {
        PrimaryTextField(title: "Category", text: $viewModel.productName) {
            PickerTextField(selectedItem: $viewModel.productName, items: ["Ahmed", "Ali", "Saad"])
        }
    }
    
    private var unitField: some View {
        PrimaryTextField(title: "Unit", text: $viewModel.productName) {
            PickerTextField(selectedItem: $viewModel.productName, items: ["Ahmed", "Ali", "Saad"])
        }
    }
    
    private var barcodeField: some View {
        PrimaryTextField(title: "Bar Code", text: $viewModel.productName, fieldView: {
            HStack {
                TextField("", text: $viewModel.productName)
                
                Button {
                    router.present(BarCodeScannerViewController())
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.custom(size: 20, weight: .semibold))
                }
            }
        })
        .keyboardType(.numberPad)
    }
}

#Preview {
    TabBarView()
}
