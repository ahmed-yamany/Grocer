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
        VStack(spacing: .Constants.cellSpacing) {
            Spacer()
            Image(.assetEmpty)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            Text(text)
                .font(.h6)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.horizontal, .Constants.contentPadding)
        .padding(.bottom, .Constants.tabBarHeight * 2)
        
    }
}
