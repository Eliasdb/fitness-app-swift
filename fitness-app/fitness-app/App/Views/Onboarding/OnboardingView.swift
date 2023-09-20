//
//  OnboardingView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selection: Int = 0
    @Binding var showOnboarding: Bool
    var body: some View {
        TabView(selection: $selection) {
            OnboardingFirstPageView(nextAction: goNext)
                .tag(0)
            OnboardingSecondPageView(nextAction: goNext)
                .tag(1)
            
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
