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
                Button("Click Me") {
                    router.present(UIHostingController(rootView: Text("Hello").primaryDesignStyle()))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbar {
            ToolbarItem {
                Text("Hi ahmed")
            }
        }
    }
}

#Preview {
    HomeView(router: NavigationRouter(navigationController: .init()))
}
