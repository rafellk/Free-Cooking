//
//  SearchNavigationView.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 19/05/21.
//

import SwiftUI

struct SearchNavigationView: View {
    
    var body: some View {
        HStack {
            NavigationTitleView()
            Spacer()
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
        }
    }
}

struct SearchNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavigationView()
    }
}
