//
//  EmptyView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 16/02/2024.
//

import SwiftUI

struct EmptyView: View {
    let text: String
    
    var body: some View {
        VStack {
            Spacer()
            Image(.assetEmpty)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text(text)
                .font(.h6)
            Spacer()
        }
        .padding(.bottom, .Constants.tabBarHeight * 2)
    }
}
