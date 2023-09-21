//
//  OnboardingThirdPage.swift
//  Dawn
//
//  Created by Elias on 21/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct OnboardingThirdPageView: View {
    @Binding var firstName: String
    @Binding var age: Int
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var sex: String
    @Binding var activityLevel: String
    @ObservedObject var vm = OnboardingViewModel()

    var body: some View {
        printv(vm.calculateGainWeight(age: 26, weight: 70, height: 180, sex: "Male", activityLevel: "Very heavy", workingOut: true))
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    OnboardingThirdPageView()
//}
