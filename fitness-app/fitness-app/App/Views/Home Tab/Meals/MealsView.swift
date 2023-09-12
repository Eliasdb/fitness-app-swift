//
//  MealsView.swift
//  Dawn
//
//  Created by Elias on 26/07/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct MealsView: View {

    // swiftdata dynamic query
    @Query private var meals: [Meal]    
    @Binding var currentDate: Date

    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        // sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .reverse)
        ]
        self._meals = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
        
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 35) {
                ForEach(meals) { meal in
                    MealRowView(meal: meal, currentDate: $currentDate)
                }
            }
            .padding([.vertical, .leading], 15)
            .padding(.top, 15)
            .overlay {
                if meals.isEmpty {
                    Text("No meals found...")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .frame(width: 150)
                }
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    HomeView()
        .modelContainer(for: [Meal.self], inMemory: true)
}
