//
//  OnboardingView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct OnboardingView: View {
    @State private var selection: Int = 0
    @Binding var showOnboarding: Bool
    
    @Binding var firstName: String
    @Binding var age: Int
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var sex: String
    @Binding var activityLevel: String
    
    var body: some View {
        TabView(selection: $selection) {
            OnboardingFirstPageView(nextAction: goNext)
                .tag(0)
            OnboardingSecondPageView(nextAction: goNext, firstName: $firstName, age: $age, weight: $weight, height: $height, sex: $sex, activityLevel: $activityLevel)
                .tag(1)
            OnboardingThirdPageView(firstName: $firstName, age: $age, weight: $weight, height: $height, sex: $sex, activityLevel: $activityLevel)
                .tag(2)
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    func goNext() {
        withAnimation {
            if selection < 1 {
               
                    selection += 1
                
            } else {
                showOnboarding = false
        }
        }
    }
    
}


//#Preview {
//    OnboardingView()
//}
