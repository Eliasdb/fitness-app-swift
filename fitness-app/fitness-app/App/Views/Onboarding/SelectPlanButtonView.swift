//
//  SelectPlanButton.swift
//  Dawn
//
//  Created by Elias on 22/09/2023.
//

import SwiftUI

struct SelectPlanButton: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var kcalGoal: Int
    @State var pGoal: Bool
    @State var pGoalInt: Int


    @State var title: String
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundStyle(isSelected ? color : .gray)
            VStack {
                Text(title)
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    
                Text("kcal goal: \(kcalGoal)")
                    .foregroundStyle(.green)
                
                if pGoal {
                    Text("protein goal: \(pGoalInt)")
                        .foregroundStyle(.red)
                    
                }
               
            }

        }
    }
}

#Preview {
    SelectPlanButton(isSelected: .constant(false), color: .blue, kcalGoal: 4000, pGoal: false, pGoalInt: 50, title: "Lose weight")
}
