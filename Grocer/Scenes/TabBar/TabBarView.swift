//
//  TabBarView.swift
//  Clarity
//
//  Created by Ahmed Yamany on 30/12/2023.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = TabBarViewModel.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
            TabBar(viewModel: viewModel)
        }
        .ignoresSafeArea()
        .animation(.interpolatingSpring, value: viewModel.selectedTab)
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(TabBarType.allCases, id: \.hashValue) { tabBarType in
                tabBarType.view
                    .tag(tabBarType)
                    .ignoresSafeArea()
                    .tint(Color.grTextSecondary)
            }
        }
    }
}

private struct TabBar: View {
    @ObservedObject var viewModel: TabBarViewModel
    @Namespace var animation
    var body: some View {
        HStack {
            ForEach(TabBarType.allCases, id: \.hashValue) { tabBarType in
                item(for: tabBarType)
                    .frame(maxWidth: .infinity)
                    .background {
                        if viewModel.selectedTab == tabBarType {
                            item(for: tabBarType)
                                .matchedGeometryEffect(id: "icon", in: animation)
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .padding(.bottom, UIApplication.shared.mainWindow?.safeAreaInsets.bottom)
        .background(.ultraThinMaterial)
    }
    
    @ViewBuilder
    private func item(for tabBarType: TabBarType) -> some View {
        VStack(spacing: 0) {
            Image(imageResource(for: tabBarType))
            Text(tabBarType.rawValue.capitalized)
                .font(.XSmall(weight: .semibold))
        }
        .onTapGesture {
            viewModel.selectedTab = tabBarType
        }
    }
    
    private func imageResource(for tabBarType: TabBarType) -> ImageResource {
        viewModel.selectedTab == tabBarType ? tabBarType.iconOnSelected : tabBarType.icon
    }
}

#Preview {
    TabBarView()
}
