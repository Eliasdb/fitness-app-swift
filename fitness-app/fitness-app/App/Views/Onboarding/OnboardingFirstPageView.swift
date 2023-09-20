//
//  OnboardingPageView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI

struct OnboardingFirstPageView: View {
    var nextAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.mixed.cardio")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
                .foregroundStyle(.mint)
            
            Text("Hello")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Welcome to Dawn. A useful tool to aid you in your quest for fitness.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .foregroundStyle(.gray)
            
            Button("Let's get started") {
                print("do it")
                nextAction()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }.padding()
    }
}
//
//#Preview {
//    OnboardingFirstPageView(nextAction: <#T##() -> Void#>)
//}
