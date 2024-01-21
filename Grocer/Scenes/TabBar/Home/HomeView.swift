//
//  HomeView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 06/01/2024.
//

import SwiftUI

struct HomeView: View {
    let router: Router
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        ScrollView {
            VStack {
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbarTitle("Home")
    }
}

#Preview {
    HomeView(router: NavigationRouter(navigationController: .init()))
}
