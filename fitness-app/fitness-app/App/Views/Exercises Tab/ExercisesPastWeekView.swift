//
//  CaloriesPastWeekView.swift
//  Dawn
//
//  Created by Elias on 08/09/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct ExercisesPastWeekView: View {
    @Query private var exercisesPastWeek: [Exercise]
    @State private var today: Date = .init()
    @State private var exercise: String = "Deadlift"
    
    var exercises = ["Deadlift", "Bodyweight Squat"]

    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -7, to: startOfDate)!
        let predicate = #Predicate<Exercise> {
            return $0.creationDate <= startOfDate && $0.creationDate > todayminus30
        }
        
//         sorting
        let sortDescriptor = [
            SortDescriptor(\Exercise.creationDate, order: .forward)
        ]
        
        self._exercisesPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    func exerciseChartData (exercises: [Exercise]) -> Array<(key: String, value: Int)> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"

        let groupedExercisesbyDate = Dictionary(grouping: exercisesPastWeek.filter{$0.title.contains(exercise)}.sorted( by: { $0.creationDate < $1.creationDate }), by: { dateFormatter.string(from: $0.creationDate) })
        
        let groupedExercisesKeys = groupedExercisesbyDate.map {$0.key }
        let groupedExercisesValues = groupedExercisesbyDate.map {$0.value.map {$0.totalAmount}.reduce(0,+) }
        
        let exercisesDictionary = Dictionary(uniqueKeysWithValues: zip(groupedExercisesKeys, groupedExercisesValues))
        let sortedExercisesDictionary = exercisesDictionary.sorted( by: { $0.0 < $1.0 })
        
        return sortedExercisesDictionary
    }

    
//    func getAverage (exercises: [Exercise]) -> Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM"
//        
//        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
//        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
//        
//        let average = ((groupedMealsValues.reduce(0, +) / (groupedMealsValues.count)) )
//        return average
//
//    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text("Weekly average")
            Text("0 reps")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            Chart {
//                RuleMark(x: .value("Goal", 3000))
//                    .foregroundStyle(Color.mint)
//                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                    .annotation(alignment: .trailing) {
//                        Text("Goal")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
                ForEach(exerciseChartData(exercises: exercisesPastWeek), id: \.value) { item in
                    LineMark(x: .value("amount", item.key), y: .value("month", item.value))
                    .foregroundStyle(Color.accentColor.gradient)}
            }
            .frame(height: 180)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            
            Picker("", selection: $exercise) {
                ForEach(exercises.sorted(by: <), id: \.self) { item in
                    Text("\(item)")
                   
                }
            }
//            .pickerStyle(.segmented)
        })

    }
}

//#Preview {
//    if #available(iOS 17.0, *) {
//        CaloriesPastWeekView()
//    } else {
//        // Fallback on earlier versions
//    }
//}
