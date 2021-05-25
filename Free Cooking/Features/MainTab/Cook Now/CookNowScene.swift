//
//  CookNowScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 20/05/21.
//

import SwiftUI

struct CookNowScene: View {
    var body: some View {
        ZStack {
            Color.defaultBackground
                .ignoresSafeArea()
            VStack {
                Spacer()
                NavigationTitleView(title: "Its cooking time!")
                Spacer()
                InstructionsCardView()
                    .padding()
                Spacer()
                StepCounter(count: 10, currentStep: 3)
                Spacer(minLength: 16)
                HStack(spacing: 8) {
                    Text("Previous")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 16)
                    Text("Next")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 16)
                }
            }
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
                RadialGradient(gradient: Gradient(colors: [.white, .gray]),
                               center: .center,
                               startRadius: 2,
                               endRadius: 650)
                    .frame(width: availableWidth, height: availableWidth)
                    .cornerRadius(availableWidth / 2)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 20, y: 20)
                    .shadow(color: Color.white.opacity(0.5), radius: 10, x: -20, y: -20)
                ArcView(currentStep: 0, size: availableWidth + 32, count: count)
            }
            VStack(spacing: 8) {
                Text("Program")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                Text("\(currentStep)")
                    .font(.system(size: 56))
                    .fontWeight(.medium)
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
//            if $0 == count - 1 {
//                let from = (range * CGFloat($0)) + (offset / 2)
//                let to = from + range
//                models.append(ArcViewModel(
//                                from: from / 100,
//                                to: to / 100,
//                                color: $0 <= currentStep ? .black : Color.gray.opacity(0.4)))
//            } else {
                let from = (range * CGFloat($0)) + (offset / 2)
                let to = from + range - (offset / 2)
                models.append(ArcViewModel(
                                from: from / 100,
                                to: to / 100,
                                color: $0 <= currentStep ? .black : Color.gray.opacity(0.4)))
//            }
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Step 1/10")
                    .font(.system(size: 12))
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 12, height: 12, alignment: .center)
                    Text("Connected to TM6")
                        .font(.system(size: 12))
                }
            }
            Text("Start with basics")
                .font(.system(size: 18))
                .fontWeight(.medium)
            Text("""
            Chop pumpkin and sweet potato into small chunks, put them to the bowl.

            Then add water and paprika. Select program no. 3 and cook for 20 mins.
            """)
                .fontWeight(.thin)
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct CookNowScene_Previews: PreviewProvider {
    static var previews: some View {
        CookNowScene()
            .previewDevice("iPhone SE (1st generation)")
        CookNowScene()
    }
}
