//
//  MyRecipesScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 19/05/21.
//

import SwiftUI

struct MyRecipesScene: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.defaultBackground
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    SearchNavigationView()
                    Spacer(minLength: 48)
                    ZStack {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer(minLength: 50)
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                            }
                            .frame(width: (UIScreen.main.bounds.size.width - 32) / 2 - 8)
                        }
                        
                        HStack {
                            VStack {
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                RecipesView(title: "Italian pasta",
                                            description: "Tasty traditional dish. Not only for Italian who went to Malta",
                                            time: "5 min",
                                            people: "1 pers")
                                Spacer(minLength: 50)
                            }
                            .frame(width: (UIScreen.main.bounds.size.width - 32) / 2 - 8)
                            Spacer()
                        }
                    }
                    Spacer(minLength: 16)
                }
                .padding([.leading, .trailing], 16)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

private struct RecipesView: View {
    
    private let title: String
    private let description: String
    private let time: String
    private let people: String
    
    init(title: String, description: String, time: String, people: String) {
        self.title = title
        self.description = description
        self.time = time
        self.people = people
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                        Image("recommendation-section")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
            Spacer(minLength: 8)
            Text(title)
                .fontWeight(.medium)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer(minLength: 8)
            Text(description)
                .fontWeight(.thin)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .foregroundColor(.secondary)
            Spacer()
            TimeAndPeopleView(time: time, people: people, spaced: true)
        }
        .padding()
        //        .frame(width: (UIScreen.main.bounds.size.width - 32) / 2 - 8)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct MyRecipes_Previews: PreviewProvider {
    
    static var previews: some View {
        MyRecipesScene()
            .previewDevice("iPhone SE (1st generation)")
        MyRecipesScene()
    }
}
