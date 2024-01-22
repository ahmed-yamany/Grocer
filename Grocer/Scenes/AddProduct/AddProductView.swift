//
//  AddProductView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct AddProductView: View {
    @ObservedObject private var viewModel: AddProductViewModel
    
    init(router: Router) {
        self.viewModel = AddProductViewModel(router: router)
    }
    
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
                productImagesView
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbarTitle("Add Product")
    }
    
    private var nameField: some View {
        PrimaryTextField(title: "Name", text: $viewModel.name) {
            TextField("", text: $viewModel.name)
        }
        .keyboardType(.default)
    }
    
    private var quantityField: some View {
        PrimaryTextField(title: "Quantity", text: $viewModel.quantity, fieldView: {
            TextField("", text: $viewModel.quantity)
        })
        .keyboardType(.numberPad)
    }
    
    private var priceField: some View {
        PrimaryTextField(title: "Price", text: $viewModel.price, fieldView: {
            TextField("", text: $viewModel.price)
        })
        .keyboardType(.decimalPad)
    }
    
    private var categoryField: some View {
        PrimaryTextField(title: "Category", text: $viewModel.category) {
            PickerTextField(selectedItem: $viewModel.category, items: ["Ahmed", "Ali", "Saad"])
        }
    }
    
    private var unitField: some View {
        PrimaryTextField(title: "Unit", text: $viewModel.unit) {
            PickerTextField(selectedItem: $viewModel.unit, items: ["Ahmed", "Ali", "Saad"])
        }
    }
    
    private var barcodeField: some View {
        PrimaryTextField(title: "Bar Code", text: $viewModel.barcode, fieldView: {
            HStack {
                TextField("", text: $viewModel.barcode)
                
                Button {
                    viewModel.startBarCodeScanner()
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .font(.custom(size: 20, weight: .semibold))
                }
            }
        })
        .keyboardType(.numberPad)
    }
    
    private var productImagesView: some View {
        Group {
            if viewModel.images.isEmpty {
                uploadImageView
            } else {
                HStack {
                    
                }
            }
        }
        .frame(height: 180)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var uploadImageView: some View {
        Button {
            
        } label: {
            Image(.assetProductImageAdd)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding().padding()
        }
    }
}

#Preview {
    TabBarView()
}
