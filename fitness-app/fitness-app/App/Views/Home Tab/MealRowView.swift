//
//  MealRowView.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct MealRowView: View {
    @Environment(\.modelContext) private var context
    @State private var mealToEdit: Meal?
    @Bindable var meal: Meal

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
                Label("\(meal.calories) kcal", systemImage: "fork.knife.circle")
                    .font(.subheadline)
                    .foregroundStyle(.black)
                
            })
            .padding(15)
            .hSpacing(.leading)
            .background(meal.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview,.rect(cornerRadius: 15) )
            .contextMenu {
                Button("Delete meal", role: .destructive) {
                    context.delete(meal)
                    try? context.save()
                }
                Button("Update meal") {
                  mealToEdit = meal
                }
            }
            .offset(y: -8)
        }
        .sheet(item: $mealToEdit) {
            mealToEdit = nil
        } content: { meal in 
            UpdateMealView(meal: meal)
        }
    }
}

@available(iOS 17.0, *)
struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .modelContainer(for: [Meal.self], inMemory: true)

    }
}
