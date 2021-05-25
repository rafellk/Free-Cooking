//
//  TimeAndPeopleView.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 19/05/21.
//

import SwiftUI

struct TimeAndPeopleView: View {
    
    private let time: String
    private let people: String
    private let spaced: Bool
    
    internal init(time: String, people: String, spaced: Bool = false) {
        self.time = time
        self.people = people
        self.spaced = spaced
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 12, height: 12, alignment: .center)
                Text(time)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 8)
            if spaced {
                Spacer()
            }
            HStack(spacing: 4) {
                Image(systemName: "person.2")
                    .resizable()
                    .frame(width: 18, height: 12, alignment: .center)
                Text(people)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TimeAndPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        TimeAndPeopleView(time: "40 min", people: "4 ppl")
    }
}
