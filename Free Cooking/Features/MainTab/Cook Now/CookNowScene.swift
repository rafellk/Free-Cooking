//
//  CookNowScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 20/05/21.
//

import SwiftUI

struct CookNowScene: View {

    @State private var y: CGFloat = 250
    @State private var count = 0
    private let numberOfItems: CGFloat = 6
    private let itemHeight: CGFloat = 250

    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    ForEach(0..<Int(numberOfItems) - 1) { value in
                        InstructionsCardView(selected: value == count)
                            .padding([.leading, .trailing], 16)
                        Spacer(minLength: 12)
                            .opacity(value == count ? 1 : 0)
                    }
                }
                .offset(y: self.y)
                .highPriorityGesture(DragGesture()
                                        .onEnded({ value in
                                            if value.translation.height > 0 {
                                                self.count -= 1
                                                if self.y + itemHeight > itemHeight {
                                                    self.y = itemHeight - 12
                                                    self.count = 0
                                                } else {
                                                    self.y += itemHeight - 12
                                                }
                                            } else {
                                                self.count += 1
                                                if self.y - itemHeight < -(itemHeight * (numberOfItems - 3)) {
                                                    self.y = -((itemHeight - 12) * (numberOfItems - 3))
                                                    self.count = Int(numberOfItems - 2)
                                                } else {
                                                    self.y -= (itemHeight - 12)
                                                }
                                            }
                                        }))
                .animation(.spring())
            }
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
            .offset(y: self.count > 0 ? -500 : 0)
            .animation(.spring())
        }
    }
}

private struct StepCounter: View {
    
    private let count: Int
    private let currentStep: Int
    
    init(count: Int, currentStep: Int) {
        self.count = count
        self.currentStep = currentStep
    }
    
    var body: some View {
        let availableWidth = (UIScreen.main.bounds.width - 32) * 0.6
        ZStack {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.cardBackground, .gray]),
                               center: .center,
                               startRadius: 2,
                               endRadius: 650)
                    .frame(width: availableWidth, height: availableWidth)
                    .cornerRadius(availableWidth / 2)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 20, y: 20)
                    .shadow(color: Color.white.opacity(0.1), radius: 10, x: -20, y: -20)
                ArcView(currentStep: 0, size: availableWidth + 32, count: count)
            }
            VStack(spacing: 8) {
                Text("Program")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(Color.primaryLabel)
                Text("\(currentStep)")
                    .font(.system(size: 56))
                    .fontWeight(.medium)
                    .foregroundColor(Color.primaryLabel)
            }
        }
    }
}

private struct ArcView: View {
    
    private struct ArcViewModel: Hashable {
        let from: CGFloat
        let to: CGFloat
        let color: Color
        
        init(from: CGFloat, to: CGFloat, color: Color) {
            self.from = from
            self.to = to
            self.color = color
        }
    }
    
    private let size: CGFloat
    private let count: Int
    private let currentStep: Int
    private var models = [ArcViewModel]()
    
    init(currentStep: Int, size: CGFloat, count: Int) {
        self.size = size
        self.count = count
        self.currentStep = currentStep
        
        let offset: CGFloat = 1
        let range: CGFloat = (100 - offset) / CGFloat(count)
        
        (0..<count).forEach {
            let from = (range * CGFloat($0)) + (offset / 2)
            let to = from + range - (offset / 2)
            models.append(ArcViewModel(
                            from: from / 100,
                            to: to / 100,
                            color: $0 <= currentStep ? Color.stepCounterFilledStroke :
                                Color.stepCounterEmptyStroke))
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<models.count, id: \.self) {
                Circle()
                    .trim(from: self.models[$0].from, to: self.models[$0].to)
                    .rotation(.degrees(-90))
                    .stroke(self.models[$0].color, style: StrokeStyle(lineWidth: 5))
                    .frame(width: size, height: size)
            }
        }
    }
}

//private struct ArcShape: Shape {
//
//    private let center: CGPoint
//    private let radius: CGFloat
//    private let startAngle: Angle
//    private let endAngle: Angle
//
//    internal init(center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle) {
//        self.center = center
//        self.radius = radius
//        self.startAngle = startAngle
//        self.endAngle = endAngle
//    }
//
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        p.addArc(center: center,
//                 radius: radius,
//                 startAngle: startAngle,
//                 endAngle: endAngle,
//                 clockwise: true)
//
//        return p.strokedPath(.init(lineWidth: 3))
//    }
//}

private struct InstructionsCardView: View {

    var selected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Step 1/10")
                    .font(.system(size: 12))
                    .foregroundColor(selected ? Color.white : .primaryLabel)
                Spacer()
            }
            Text("Start with basics")
                .font(.system(size: 22))
                .fontWeight(.medium)
                .foregroundColor(selected ? Color.white : .primaryLabel)
            Spacer()
            Text("""
            Chop pumpkin and sweet potato into small chunks, put them to the bowl.

            Then add water and paprika. Select program no. 3 and cook for 20 mins.
            """)
                .fontWeight(.light)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                .foregroundColor(selected ? Color.white : .primaryLabel)
        }
        .padding(24)
        .frame(height: selected ? 250 : 250 - 12)
        .background(selected ? Color.selectedStep : Color.cardBackground)
        .cornerRadius(8)
        .padding([.leading, .trailing], selected ? 0 : 12)
    }
}

struct CookNowScene_Previews: PreviewProvider {
    static var previews: some View {
        CookNowScene()
            .preferredColorScheme(.dark)
        CookNowScene()
    }
}
