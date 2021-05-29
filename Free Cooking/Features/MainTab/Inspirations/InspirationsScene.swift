//
//  InspirationsScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 17/05/21.
//

import SwiftUI

struct InspirationsScene: View {
    
    init() {
        UINavigationBar.changeAppearance(clear: true)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.defaultBackground
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    SearchNavigationView()
                    Spacer(minLength: 48)
                    HeaderSectionView()
                    Spacer(minLength: 48)
                    RecommendationsSectionView(recommender: "René Redzepi",
                                               name: "Vegan Thai Curry Soup",
                                               description: "Spice lovers will slurp up this soup in seconds. Featuring chili powder, smoked paprika, and cayenne pepper, every bowl brings the heat.")
                    Spacer(minLength: 8)
                }
                .padding([.leading, .trailing], 16)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

private struct HeaderSectionView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                HeaderSectionItemView(headerFirstLine: "Recipe", headerSecondLine: "of the day", name: "Roasted Pumpkin Soup", time: "50 min", people: "4 ppl")
                HeaderSectionItemView(headerFirstLine: "Try it", headerSecondLine: "tomorrow", name: "Caroline's Roasted Pumpkin Soup", time: "20 min", people: "10 ppl")
                HeaderSectionItemView(headerFirstLine: "And for the", headerSecondLine: "weekend", name: "Baby Bel", time: "1 h", people: "10 ppl")
            }
        }
    }
}

private struct HeaderSectionItemView: View {
    
    private let headerFirstLine: String
    private let headerSecondLine: String
    private let name: String
    private let time: String
    private let people: String
    
    init(headerFirstLine: String, headerSecondLine: String, name: String, time: String, people: String) {
        self.headerFirstLine = headerFirstLine
        self.headerSecondLine = headerSecondLine
        self.name = name
        self.time = time
        self.people = people
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(headerFirstLine)
                    .font(.system(size: 32))
                    .fontWeight(.semibold)
                Text(headerSecondLine)
                    .font(.system(size: 32))
                    .fontWeight(.ultraLight)
                Text(name)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .padding(.top, 16)
                    .lineLimit(1)
                
                TimeAndPeopleView(time: time, people: people)
                    .padding(.top, 4)
                
                Image("header-image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(24)
        .background(Color.cardBackground)
        .cornerRadius(8)
        .frame(width: 275)
    }
}

private struct RecommendationsSectionView: View {
    
    private let recommender: String
    private let name: String
    private let description: String
    
    init(recommender: String, name: String, description: String) {
        self.recommender = recommender
        self.name = name
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recommender)
                .font(.system(size: 32))
                .fontWeight(.semibold)
            Text("recommends you")
                .font(.system(size: 32))
                .fontWeight(.ultraLight)
            Spacer(minLength: 16)
            VStack(alignment: .leading) {
                Image("recommendation-section")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Spacer(minLength: 16)
                Text(name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                Spacer(minLength: 16)
                Text(description)
                    .font(.system(size: 16))
                    .fontWeight(.thin)
            }
            .padding(24)
            .background(Color.cardBackground)
            .cornerRadius(8)
            Spacer(minLength: 16)
            NavigationLink(destination: Text("Not yet implemented")) {
                Text("Browse more recipes")
                    .foregroundColor(Color.primaryLabel)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.browseMoreButtonBackground)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.browseMoreButtonBorder, lineWidth: 1.4)
                    )
                    .padding([.leading, .trailing], 1)
                    .padding(.bottom, 16)
            }
        }
    }
}

struct InspirationsScene_Previews: PreviewProvider {
    static var previews: some View {
        InspirationsScene()
            .preferredColorScheme(.dark)
        InspirationsScene()
    }
}
