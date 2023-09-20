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
    @ObservedObject var vm = ExercisesViewModel()
    @State private var today: Date = .init()
    @Binding var exercise: String
    @Binding var category: String 
    @Binding var weekIndex: Int
    
    var exercisesAbs = ["Plank", "Bicycle Crunch", "Hollow hold", "Bird dog exercise"]
    var exercisesArms = [ "Bicep dumbbell curl", "Overhead Triceps Extension"]
    var exercisesBack = [ "One-arm dumbbell row", "Bridge"]
    var exercisesChest = [ "Push ups", "Dumbbell bench press"]
    var exercisesLegs = ["Deadlift", "Bodyweight Squat"]

    @State private var categories: [String : [(name: String, sets: Int, reps: Int)]] =
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


    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 4, content: {
                            HStack(content: {
                                Button(action: {
                                    weekIndex+=1
                                    
                                    if weekIndex >= vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise).count {
                                        weekIndex = 0
                                    }
                                }, label: {
                                    Image(systemName: "chevron.left").foregroundStyle(Color("TestColor"))
                                }).buttonStyle(BorderlessButtonStyle())
                                Spacer()
                                if vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].isEmpty {
                                    Text("No data yet.")
                                        .font(.footnote)
                                        .foregroundStyle(Color("TestColor"))
                                        .fontWeight(.bold)
                                } else if !vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].isEmpty {
                                    Text("\(String(describing: vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].last!.date)) - \(String(describing: vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(Color("TestColor"))
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                Button(action: {
                                    weekIndex-=1
                                    
                                    if weekIndex == -1 {
                                        weekIndex = 0
                                    }
                                    
                                }, label: {
                                    Image(systemName: "chevron.right").foregroundStyle(Color("TestColor"))
                                }).buttonStyle(BorderlessButtonStyle())
                            })
                            .padding(.top, 20)
                            Spacer()
                            VStack(alignment: .leading, spacing: 4, content: {
                                Text("Average")
                                Text("\(vm.getAverage(exercises: exercisesPastWeek, exercise: exercise, category: category)) reps")
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
                                    ForEach(vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                       BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                        .foregroundStyle(Color("TestColor").gradient)}
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
                        })

                    }
                }
            } label: {
                ExerciseDetailView()
            }
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//   ExercisesPastWeekView()
//}

