//
//  TabBarView.swift
//  Clarity
//
//  Created by Ahmed Yamany on 30/12/2023.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var viewModel = TabBarViewModel.shared
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabView
            TabBar(viewModel: viewModel)
                .transition(.move(edge: .bottom))
                .isHidden(viewModel.tabBarIsHidden)
        }
        .ignoresSafeArea()
        .animation(.interactiveSpring(dampingFraction: 0.7, blendDuration: 0.3), value: viewModel.selectedTab)
        .animation(.interactiveSpring(dampingFraction: 0.6, blendDuration: 0.7), value: viewModel.tabBarIsHidden)
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(TabBarType.allCases, id: \.hashValue) { tabBarType in
                tabBarType.view
                    .tag(tabBarType)
                    .ignoresSafeArea()
                    .tint(Color.grTextSecondary)
                    .accentColor(Color.grTextSecondary)
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
        VStack(spacing: 4) {
            Image(imageResource(for: tabBarType))
            Text(tabBarType.title)
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
