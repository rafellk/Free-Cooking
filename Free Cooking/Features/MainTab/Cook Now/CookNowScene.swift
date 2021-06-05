//
//  CookNowScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 20/05/21.
//

import SwiftUI

struct CookNowScene: View {

    @State private var y: CGFloat = 250
    @State private var current = 0

    private let originalPosition: CGFloat = 250
    private let items: [InstructionsCardView.Model] = Array.init(
        repeating: InstructionsCardView.Model(currentStep: 1,
                                              numberOfSteps: 10,
                                              headline: "Start with the basics",
                                              instructions: """
                                                                    Chop pumpkin and sweet potato into small chunks, put them to the bowl.

                                                                    Then add water and paprika. Select program no. 3 and cook for 20 mins.
                                                                    """,
                                              availableWidth: UIScreen.main.bounds.width),
        count: 6)

    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            carrouselView
            ZStack {
                VStack {
                    Image("recommendation-section")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .ignoresSafeArea()
                VStack {
                    Color.black
                        .opacity(0.8)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .ignoresSafeArea()
                VStack() {
                    HStack {
                        NavigationTitleView(title: "Italian pasta",
                                            fontSize: 48,
                                            fontWeigth: .regular,
                                            fontColor: .white)
                            .padding(.top, 120)
                            .padding([.leading, .trailing], 24)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .offset(y: self.current > 0 ? -500 : 0)
            .animation(.spring())
        }
    }

    var carrouselView: some View {
        VStack(spacing: 0) {
            ForEach(0..<items.count) { value in
                InstructionsCardView(model: items[value], selected: value == current)
                    .padding([.leading, .trailing], 16)
                Spacer(minLength: 12)
                    .opacity(value == current ? 1 : 0)
            }
        }
        .offset(y: self.y)
        .highPriorityGesture(DragGesture().onEnded({ value in
            let numberOfItems: CGFloat = CGFloat(items.count)

            // Going up
            if value.translation.height > 0 {
                let previous = self.current
                self.current -= 1
                self.current = max(0, self.current)
                print("going up current: \(self.current)")
                print("going up item size: \(self.items[self.current].size)")

                if self.y + self.items[self.current].size > self.items[self.current].size {
                    self.y = self.originalPosition
                } else if previous != self.items.count - 1 {
                    self.y += self.items[self.current].size - 12
                }
            } else { // Going down
                self.current += 1
                self.current = min(self.items.count - 1, self.current)
                print("going down current: \(self.current)")
                print("going down item size: \(self.items[self.current].size)")

                if !(self.y - self.items[self.current].size < -(self.items[self.current].size * (numberOfItems - 3))) {
                    self.y -= (self.items[self.current].size - 12)
                }
            }
        }))
        .animation(.spring())
    }
}

private struct InstructionsCardView: View {

    var model: Model
    var selected: Bool

    init(model: Model, selected: Bool) {
        self.model = model
        self.selected = selected
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Step \(model.currentStep)/\(model.numberOfSteps)")
                    .font(.system(size: 12))
                    .foregroundColor(selected == true ? Color.white : .primaryLabel)
                Spacer()
            }
            Text(model.headline)
                .font(.system(size: 22))
                .fontWeight(.medium)
                .foregroundColor(selected == true ? Color.white : .primaryLabel)
            Text(model.instructions)
                .fontWeight(.light)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .foregroundColor(selected == true ? Color.white : .primaryLabel)
        }
        .padding(24)
        .frame(height: selected == true ? model.size : model.size - 12)
        .background(selected == true ? Color.selectedStep : Color.cardBackground)
        .cornerRadius(8)
        .padding([.leading, .trailing], selected == true ? 0 : 12)
    }

    struct Model {
        var currentStep: Int
        var numberOfSteps: Int
        var headline: String
        var instructions: String
        var availableWidth: CGFloat
        var size: CGFloat = 0

        init(currentStep: Int,
             numberOfSteps: Int,
             headline: String,
             instructions: String,
             availableWidth: CGFloat) {
            self.currentStep = currentStep
            self.numberOfSteps = numberOfSteps
            self.headline = headline
            self.instructions = instructions
            self.availableWidth = availableWidth
            let width = availableWidth - 72 // considering horizontal paddings

            size = "Step \(currentStep)/\(numberOfSteps)"
                .height(font: .systemFont(ofSize: 12),
                        width: width)

            size += 16
            size += headline.height(font: .systemFont(ofSize: 22),
                                          width: width)
            size += 16
            size += instructions.height(font: .systemFont(ofSize: 16),
                                              width: width)
            size += 48
        }
    }
}

struct CookNowScene_Previews: PreviewProvider {
    static var previews: some View {
        CookNowScene()
            .preferredColorScheme(.dark)
        CookNowScene()
    }
}

extension String {
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        let attrString = NSAttributedString(string: self,
                                            attributes: [.font: font])
        let bounds = attrString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        return bounds.height
    }
}
