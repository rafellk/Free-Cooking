//
//  OnboardingScene.swift
//  Free Cooking
//
//  Created by Goncalves, Rafael on 17/05/21.
//

import SwiftUI

struct OnboardingScene: View {
    
    init() {
        UINavigationBar.changeAppearance(clear: true)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.defaultBackground
                    .ignoresSafeArea()
                
                VStack {
                    NavigationTitleView()
                        .padding(.top, 16)
                    
                    Spacer()
                    
                    VStack {
                        Image("onboarding")
                            .padding(.bottom, 48)
                        Text("All the recipes on your fingertips")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                        Text("Cooking on Termomix made easy")
                            .font(.system(size: 16))
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                    }
                    .padding([.leading, .trailing], 16)
                    
                    Spacer()
                    
                    NavigationLink(destination: MainTabScene()) {
                        Text("Let's Start")
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
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingScene()
                .previewDevice("iPhone SE (1st generation)")
            OnboardingScene()
        }
    }
}
