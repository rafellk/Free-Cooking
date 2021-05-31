//
//  NavigationTitleView.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 17/05/21.
//

import SwiftUI

struct NavigationTitleView: View {
    
    private let title: String
    private let fontSize: CGFloat
    private let fontWeigth: Font.Weight
    private let fontColor: Color
    
    init(title: String = "Cooksy", fontSize: CGFloat = 24, fontWeigth: Font.Weight = .semibold, fontColor: Color = .primaryLabel) {
        self.title = title
        self.fontSize = fontSize
        self.fontWeigth = fontWeigth
        self.fontColor = fontColor
    }
    
    var body: some View {
        Text(title)
            .fontWeight(fontWeigth)
            .font(.system(size: fontSize))
            .foregroundColor(fontColor)
    }
}
