//
//  ArcView.swift
//  Free Cooking
//
//  Created by Rafael Lucena on 6/5/21.
//

import SwiftUI

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

private struct ArcShape: Shape {

    private let center: CGPoint
    private let radius: CGFloat
    private let startAngle: Angle
    private let endAngle: Angle

    internal init(center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle) {
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = endAngle
    }

    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: true)

        return p.strokedPath(.init(lineWidth: 3))
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView(currentStep: 1,
                size: (UIScreen.main.bounds.width - 32) * 0.6,
                count: 10)
    }
}
