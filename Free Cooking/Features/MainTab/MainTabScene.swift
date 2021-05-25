//
//  MainTabScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 17/05/21.
//

import SwiftUI

struct MainTabScene: View {

    private var tabs = [
        TabItem(title: "Inspirations", icon: "lightbulb"),
        TabItem(title: "My recipes", icon: "list.star"),
        TabItem(title: "Cook now!", icon: "timer"),
        TabItem(title: "Settings", icon: "gearshape"),
    ]
    private var screenWidth: CGFloat = UIScreen.main.bounds.width - 32
    @State private var selectedTab = "Inspirations"

    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {
                GeometryReader { _ in
                    ZStack {
                        InspirationsScene()
                            .opacity(selectedTab == "Inspirations" ? 1 : 0)
                        MyRecipesScene()
                            .opacity(selectedTab == "My recipes" ? 1 : 0)
                        CookNowScene()
                            .opacity(selectedTab == "Cook now!" ? 1 : 0)
                        Text("Settings")
                            .opacity(selectedTab == "Settings" ? 1 : 0)
                    }
                }
                HStack {
                    Spacer()
                    ForEach(tabs, id: \.self) { tab in
                        TabItemView(tab: tab, selectedTab: $selectedTab)
                            .frame(width: (screenWidth - 40) / 4)
                            .padding([.top, .bottom], 8)
                            .background(tab.title == selectedTab ? Color.black : Color.white)
                            .cornerRadius(8)
                        Spacer()
                    }
                }
                .padding([.top, .bottom], 8)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                .padding([.leading, .trailing], 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

private struct TabItemView: View {

    let tab: TabItem
    @Binding var selectedTab: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tab.icon)
                .frame(width: 20, height: 20)
                .foregroundColor(tab.title == selectedTab ? Color.white : Color.black)
            Text(tab.title)
                .font(.system(size: 12))
                .foregroundColor(tab.title == selectedTab ? Color.white : Color.black)
        }
        .onTapGesture {
            withAnimation { selectedTab = tab.title }
        }
    }
}

private struct TabItem: Hashable {

    var title: String
    var icon: String

    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}

struct MainTabScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabScene()
                .previewDevice("iPhone SE (1st generation)")
            MainTabScene()
        }
    }
}
