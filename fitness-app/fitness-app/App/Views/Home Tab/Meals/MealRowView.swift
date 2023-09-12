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
    @Binding var currentDate: Date

    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .leading, spacing: 8, content: {
                Text(meal.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                Label("\(meal.calories) kcal", systemImage: "fork.knife.circle")
                    .font(.subheadline)
                    .foregroundStyle(.black)
                
            })
            .padding(15)
            .hSpacing(.leading)
            .background(meal.tintColor, in: .rect(bottomTrailingRadius: 15,topTrailingRadius: 15 ))
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
            .offset(x:-15)
            .sheet(item: $mealToEdit) {
                mealToEdit = nil
            } content: { meal in
                UpdateMealView(meal: meal, currentDate: $currentDate)
                    .presentationDetents([.height(520)])
                    .interactiveDismissDisabled()
                    .presentationCornerRadius(30)
                    .presentationBackground(.white)
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
    
}
