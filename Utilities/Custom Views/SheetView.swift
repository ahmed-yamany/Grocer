//
//  SheetView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct SheetView<Content: View>: View {
    let title: String
    let router: Router
    @ViewBuilder
    let content: () -> Content
    
    var body: some View {
        VStack {
            headerView
            content()
                .padding(16)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .top)
        .background(Color.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .frame(maxHeight: 320, alignment: .top)
        .padding(.horizontal, 24)
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.Large(weight: .semibold))
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    XButton {
                        router.dismiss()
                    }
                }
            
            Divider()
                .padding(.horizontal, 8)

        }
        .padding(.horizontal, 8)
        .padding(.top, 16)
    }
}
