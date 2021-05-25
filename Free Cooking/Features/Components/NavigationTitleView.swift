//
//  NavigationTitleView.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 17/05/21.
//

import SwiftUI

struct NavigationTitleView: View {
    
    private let title: String
    
    init(title: String = "Cooksy") {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .font(.system(size: 24))
    }
}
