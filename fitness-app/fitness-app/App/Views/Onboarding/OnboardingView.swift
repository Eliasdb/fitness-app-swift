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
    @State var calcPlans: Bool = false
    @State var pGoal: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            OnboardingFirstPageView(nextAction: goNext)
                .tag(0)
            OnboardingSecondPageView(nextAction: goNext, firstName: $firstName, age: $age, weight: $weight, height: $height, sex: $sex, activityLevel: $activityLevel, calcPlans: $calcPlans)
                .tag(1)
            OnboardingThirdPageView(nextAction: goNext, firstName: $firstName, age: $age, weight: $weight, height: $height, sex: $sex, activityLevel: $activityLevel, calcPlans: $calcPlans)
                .tag(2)
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    func goNext() {
        withAnimation {
            if selection < 2 {
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
