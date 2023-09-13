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
    @Binding var categories: [String : [(name: String, sets: Int, reps: Int)]]

    init(currentDate: Binding<Date>, categories: Binding<[String : [(name: String, sets: Int, reps: Int)]]>) {
        self._currentDate = currentDate
        self._categories = categories
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
        
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 35) {
                ForEach(exercises) { exercise in
                    ExerciseRowView(exercise: exercise, currentDate: $currentDate, categories: $categories)
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
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    HomeView(categories: categories)
//        .modelContainer(for: [Meal.self], inMemory: true)
//}
