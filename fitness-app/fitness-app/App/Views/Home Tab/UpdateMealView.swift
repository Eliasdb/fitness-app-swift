//
//  UpdateMealView.swift
//  Dawn
//
//  Created by Elias on 09/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct UpdateMealView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var meal: Meal
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        List {
            TextField("Meal", text: $meal.title)
            TextField("Calories", value: $meal.calories, formatter: Self.formatter)
            TextField("Protein", value: $meal.protein, formatter: Self.formatter)
            TextField("Carbs", value: $meal.carbs, formatter: Self.formatter)
            TextField("Fat", value: $meal.fat, formatter: Self.formatter)
            Button("Update meal") {
                dismiss()
            }

        }
    }
}
//
//#Preview {
//    UpdateMealView()
//}
