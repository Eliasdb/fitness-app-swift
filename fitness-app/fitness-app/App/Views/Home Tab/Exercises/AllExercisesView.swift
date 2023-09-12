//
//  MealsView.swift
//  Dawn
//
//  Created by Elias on 26/07/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct AllExercisesView: View {

    // swiftdata dynamic query
    @Query private var exercises: [Exercise]
    @Binding var currentDate: Date

    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Exercise> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        // sorting
        let sortDescriptor = [
            SortDescriptor(\Exercise.creationDate, order: .reverse)
        ]
        self._exercises = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var x = [1,2,3,4]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 35) {
                ForEach(exercises) { exercise in
                    ExerciseRowView(exercise: exercise, currentDate: $currentDate)
                }
            }
            .padding([.vertical, .leading], 15)
            .padding(.top, 15)
            .overlay {
                if exercises.isEmpty {
                    Text("No exercises found...")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .frame(width: 150)
                }
            }
//            VStack(alignment: .leading, spacing: 35) {
//                ForEach(meals) { meal in
//                    ExerciseRowView(meal:meal)
//                }
//            }
//            .padding([.vertical, .leading], 15)
//            .padding(.top, 15)
//            .overlay {
//                if meals.isEmpty {
//                    Text("No meals found...")
//                        .font(.caption)
//                        .foregroundStyle(.white)
//                        .frame(width: 150)
//                }
//            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    HomeView()
        .modelContainer(for: [Meal.self], inMemory: true)
}
