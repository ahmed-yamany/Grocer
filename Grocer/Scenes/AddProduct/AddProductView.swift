//
//  AddProductView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI
import Combine

struct AddProductView: View {
    @ObservedObject private var viewModel: AddProductViewModel
    
    init(viewModel: AddProductViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                nameField
                
                HStack(spacing: 12) {
                    quantityField
                    priceField
                }
                
                categoryField
                barcodeField
                productImagesView
                
                saveButton
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 80)
            .padding(.top, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbarTitle(L10n.AddProduct.title)
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.images)
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var nameField: some View {
        PrimaryTextField(title: L10n.Field.name, text: $viewModel.name, fieldView: {
            TextField("", text: $viewModel.name)
        })
        .keyboardType(.default)
    }
    
    private var quantityField: some View {
        PrimaryTextField(title: L10n.Field.quantity, text: $viewModel.quantity, fieldView: {
            TextField("", text: $viewModel.quantity)
        })
        .keyboardType(.numberPad)
    }
    
    private var priceField: some View {
        PrimaryTextField(title: L10n.Field.price, text: $viewModel.price, fieldView: {
            TextField("", text: $viewModel.price)
        })
        .keyboardType(.decimalPad)
    }
    
    private var categoryField: some View {
        CategoryField(
            category: $viewModel.category,
            viewModel: viewModel.categoryViewModel
        )
    }
    
    private var barcodeField: some View {
        BarCodeField(
            barcode: $viewModel.barcode,
            router: viewModel.router
        )
    }
    
    private var saveButton: some View {
        DelayButton {
            Text(L10n.save)
        } action: {
            viewModel.saveProduct()
        }
        .buttonStyle(.primaryButton())
    }

    private var productImagesView: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(viewModel.images, id: \.self) { image in
                    productImageCell(image)
                }
            }
            
            uploadImageView
                .frame(height: 180)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var uploadImageView: some View {
        Button {
            viewModel.showAddImageActionSheet = true
        } label: {
            Image(.assetProductImageAdd)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding().padding()
        }
        .actionSheet(isPresented: $viewModel.showAddImageActionSheet) {
            uploadImageActionSheet
        }
    }
    
    private var uploadImageActionSheet: ActionSheet {
        ActionSheet(
            title: Text(L10n.AddProduct.AddImage.title),
            buttons: [
                .default(Text(L10n.AddProduct.AddImage.Picker.camera)) {
                    viewModel.showImagePicker(forSourceType: .camera)
                },
                .default(Text(L10n.AddProduct.AddImage.Picker.image)) {
                    viewModel.showImagePicker(forSourceType: .photoLibrary)
                },
                .destructive(Text(L10n.cancel))
            ]
        )
    }
    
    @ViewBuilder
    private func productImageCell(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .mask(RoundedRectangle(cornerRadius: 12))
            .frame(height: 200)
            .overlay(alignment: .topTrailing) {
              XButton(action: { viewModel.remove(image) })
            }
            .padding(8)
    }
}

#Preview {
    TabBarView()
}
