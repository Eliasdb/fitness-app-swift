//
//  MealRowView.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI

struct MealRowView: View {
    @Binding var meal: Meal
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(.black)
                .frame(width: 10, height: 10)
                .padding(5)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .offset(y: 25)
          
            VStack(alignment: .leading, spacing: 8, content: {
                Text(meal.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                Label("\(meal.calories) calories", systemImage: "fork.knife.circle")
                    .font(.subheadline)
                    .foregroundStyle(.black)
                
            })
            .padding(15)
            .hSpacing(.leading)
            .background(meal.tint, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            
        }
        
    }
}

#Preview {
    HomeViewv2()
}
