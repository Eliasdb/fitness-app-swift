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
    @State private var exercise: String = "Plank"
    @State private var category: String = "Abs"
    

//    var categories = ["Abs", "Arms", "Back", "Chest", "Legs"]
    var exercisesAbs = ["Plank", "Bicycle Crunch", "Hollow hold", "Bird dog exercise"]
    var exercisesArms = [ "Bicep dumbbell curl", "Overhead Triceps Extension"]
    var exercisesBack = [ "One-arm dumbbell row", "Bridge"]
    var exercisesChest = [ "Push ups", "Dumbbell bench press"]
    var exercisesLegs = ["Deadlift", "Bodyweight Squat"]

    var categories: [String : [(name: String, sets: Int, reps: Int)]] =
    ["Abs":
            [(name: "Plank", sets: 0, reps: 0),
             (name: "Bicycle Crunch", sets: 0, reps: 0),
             (name: "Hollow hold", sets: 0, reps: 0),
             (name: "Bird dog exercise", sets: 0, reps: 0),],
     
     "Arms":
            [(name: "Bicep dumbbell curl", sets: 0, reps: 0),
             (name: "Overhead Triceps Extension", sets: 0, reps: 0)],
     
     "Back":
            [(name: "One-arm dumbbell row", sets: 0, reps: 0),
              (name: "Bridge", sets: 0, reps: 0)],
     
     "Chest":
            [(name: "Push ups", sets: 0, reps: 0),
            (name: "Dumbbell bench press", sets: 0, reps: 0)],
     
     "Legs":
            [(name: "Deadlift", sets: 0, reps: 0),
            (name: "Bodyweight Squat", sets: 0, reps: 0)]
    ]


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

        let groupedExercisesbyDate = Dictionary(grouping: exercises.filter{$0.category.contains(category)}.filter{$0.title.contains(exercise)}.sorted( by: { $0.creationDate < $1.creationDate }), by: { dateFormatter.string(from: $0.creationDate) })
        
        let groupedExercisesKeys = groupedExercisesbyDate.map {$0.key }
        let groupedExercisesValues = groupedExercisesbyDate.map {$0.value.map {$0.totalAmount}.reduce(0,+) }
        
        let exercisesDictionary = Dictionary(uniqueKeysWithValues: zip(groupedExercisesKeys, groupedExercisesValues))
        let sortedExercisesDictionary = exercisesDictionary.sorted( by: { $0.0 < $1.0 })
        
        return sortedExercisesDictionary
    }

    
    func getAverage (exercises: [Exercise]) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        let groupedExercisesbyDate = Dictionary(grouping: exercises.filter{$0.title.contains(exercise)}.sorted( by: { $0.creationDate < $1.creationDate }), by: { dateFormatter.string(from: $0.creationDate) })
        
        let groupedExercisesValues = groupedExercisesbyDate.map {$0.value.map {$0.totalAmount}.reduce(0,+) }
        
        if (groupedExercisesValues.isEmpty) {
            return 0
        }
        let average = ((groupedExercisesValues.reduce(0, +) / (groupedExercisesValues.count)) )
        return average
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text("Weekly average")
            Text("\(getAverage(exercises: exercisesPastWeek)) reps")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            Picker("", selection: $category) {
                ForEach(Array(categories.keys.sorted(by: <)), id: \.self) { item in
                    Text("\(item)")
                }
            }
            .pickerStyle(.segmented)
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
            
            
            switch category {
            case "Abs":
                Picker("", selection: $exercise) {
                    ForEach(categories["Abs"].map { $0.map {$0.name} }!, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                .onAppear() {
                          exercise = "Plank"
                      }
            case "Arms":
                Picker("", selection: $exercise) {
                    ForEach(exercisesArms, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                .onAppear() {
                          exercise = "Bicep dumbbell curl"
                      }
            case "Back":
                Picker("", selection: $exercise) {
                    ForEach(exercisesBack, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                .onAppear() {
                          exercise = "Bridge"
                      }
            case "Chest":
                Picker("", selection: $exercise) {
                    ForEach(exercisesChest, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                .onAppear() {
                          exercise = "Push ups"
                      }
            case "Legs":
                Picker("", selection: $exercise) {
                    ForEach(exercisesLegs, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                .onAppear() {
                          exercise = "Bodyweight Squat"
                      }
            default:
                Picker("", selection: $exercise) {
                    ForEach(exercisesAbs, id: \.self) { item in
                        Text("\(item)")
                            .tag(item)
                    }
                }
                
            }
      
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
