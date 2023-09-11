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
    
    func exerciseChartData () -> Array<(key: String, value: Int)>
    {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        // groups by date in dictionary and pulls out keys and values
        let groupedExercises = Dictionary(grouping: exercisesPastWeek.filter{$0.title.contains(exercise)}, by: { $0.title })
//        print(groupedExercises)
        let groupedExercisesbyDate = Dictionary(grouping: exercisesPastWeek.filter{$0.title.contains(exercise)}, by: { dateFormatter.string(from: $0.creationDate) })

        
        let groupedExercisesKeys = groupedExercisesbyDate.map {$0.key }.sorted( by: { $0 < $1 })
        let groupedExercisesReps = groupedExercises.map {$0.value.map { $0.reps } }.flatMap { item in
            return item
          }
        let groupedExercisesSets = groupedExercises.map {$0.value.map { $0.sets } }.flatMap { item in
            return item
          }
        
        print(groupedExercisesReps)
        print(groupedExercisesSets)

        
//        let totalExerciseReps = groupedExercisesReps * groupedExercisesSets



                
        let mealsDictionary = Dictionary(uniqueKeysWithValues: zip(groupedExercisesKeys, groupedExercisesSets));
        
        let sortedMealsDictionary = mealsDictionary.sorted( by: { $0.0 < $1.0 })
        
        return sortedMealsDictionary
        
        }
    
    var body: some View {
        printv(exerciseChartData())
        VStack(alignment: .leading, spacing: 4, content: {
            Text("Weekly average")
//            Text("\(getAverage(meals: mealsPastWeek)) kcal")
//                .fontWeight(.semibold)
//                .font(.footnote)
//                .foregroundStyle(.secondary)
//                .padding(.bottom, 12)
            Chart {
//                RuleMark(x: .value("Goal", 3000))
//                    .foregroundStyle(Color.mint)
//                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
//                    .annotation(alignment: .trailing) {
//                        Text("Goal")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
                ForEach(exerciseChartData(), id: \.value) { item in
                    LineMark(x: .value("amount", item.key), y: .value("month", item.value))
                    .foregroundStyle(Color.accentColor.gradient)}
            }
            .frame(height: 180)
           
//            .chartXAxis {
//                AxisMarks(values: mealChartData().map { $0.value}) { value in
//                    //                            AxisGridLine()
//                    AxisTick()
//                    AxisValueLabel()
//                }
//            }
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
