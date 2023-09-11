//
//  AddExerciseView.swift
//  Dawn
//
//  Created by Elias on 10/09/2023.
//


import SwiftUI

@available(iOS 17.0, *)
struct UpdateExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    // model context to save data
    @Environment(\.modelContext) private var context
    
    @Bindable var exercise: Exercise

    
//    @State private var exerciseDate: Date = .init()
//    @State private var selectedCategory: String = "Arms"
//    @State private var selectedExercise: String = ""
//    @State private var setAmount: Int = 0
//    @State private var repsAmount: Int = 0


    var categories: [String : [(name: String, sets: Int, reps: Int)]] =
    ["Abs":
            [(name: "Plank", sets: 0, reps: 0),
             (name: "Bicycle Crunch", sets: 0, reps: 0),
             (name: "Hollow hold", sets: 0, reps: 0),
             (name: "Bird dog exercise", sets: 0, reps: 0),
             (name: "Bicep dumbbell curl", sets: 0, reps: 0)],
     
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
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Category")
                    .font(.caption)
                    .foregroundStyle(.white)
                
                Picker("Please choose a category", selection: $exercise.category) {
                    ForEach(Array(categories.keys.sorted(by: <)), id: \.self) { key in
                        Text("\(key)")
                    }
                }
                .pickerStyle(.segmented)
                
                switch exercise.category {
                case "Chest":
                    Picker("Please choose an exercise", selection: $exercise.title) {
                        ForEach(categories["Chest"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)

                case "Abs":
                    Picker("Please choose an exercise", selection: $exercise.title) {
                        ForEach(categories["Abs"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)


                case "Arms":
                    Picker("Please choose an exercise", selection: $exercise.title) {
                        ForEach(categories["Arms"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)
                    
                case "Back":
                    Picker("Please choose an exercise", selection: $exercise.title) {
                        ForEach(categories["Back"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)
                    
                case "Legs":
                    Picker("Please choose an exercise", selection: $exercise.title) {
                        ForEach(categories["Legs"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)

      
                default:
                    Picker("Please choose a category", selection: $exercise.title) {
                        ForEach(categories["Chest"].map { $0 }!.map {$0.name}, id: \.self) { value in
                            Text("\(value)")
                                  }
                              }
                    .pickerStyle(.wheel)
                }
            })
            
            
            Section{
               GeometryReader { geometry in
                   VStack(alignment: .leading, content: {
                       Text("Frequency")
                           .font(.caption)
                           .foregroundStyle(.white)
                       HStack(alignment: .center, content: {
                           Picker("sets", selection: $exercise.sets){
                             
                               ForEach(1..<50) { i in
                                   Text("\(i) sets")
                                       .font(.caption)
                                       .tag(i)
                               }
                           }
                           .pickerStyle(.wheel)
                           .frame(width: 170, height: 40)
                           .clipped()
                           Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
                               .resizable()
                               .rotationEffect(.degrees(-90))
                               .frame(width: 10, height:10)
                               .position(x: -28, y: 19)
                              
                           Picker("reps", selection: $exercise.reps){
                               ForEach(1..<50) { i in
                                   Text("\(i) reps")
                                       .font(.caption)
                                       .tag(i)
                               }
                           }
                           .pickerStyle(.wheel)
                           .frame(width: 170, height:40)
                           .clipped()
                           Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
                               .resizable()
                               .rotationEffect(.degrees(-90))
                               .frame(width: 10, height:10)
                               .position(x: -28, y: 20)
                       })
                       .frame(height:40)
                       .cornerRadius(30)
                       
//                       HStack(alignment: .center, content: {
//
//                           Picker("fat", selection: $mealFat){
//                               ForEach(1..<50) { i in
//                                   Text("\(i) grams fat")
//                                       .font(.caption)
//                                       .tag(i)
//                               }
//                           }
//                           .pickerStyle(.wheel)
////                                   .padding(.top, 5)
//
//                           .frame(width: 170, height: 40)
//                           .clipped()
//                           Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
//                               .resizable()
//                               .rotationEffect(.degrees(-90))
//                               .frame(width: 10, height:10)
//                               .position(x: -28, y: 20)
//                       })
//                       .frame(height:40)
                   })
               }
               .frame(height:100)
            }
           
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Exercise Date")
                        .font(.caption)
                        .foregroundStyle(.white)
                    
                   DatePicker("", selection: $exercise.creationDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                        .offset(x:-115)
                })
            
          
//            .padding(.trailing, -15)
            Spacer(minLength: 0)
            Button(action: {
            // saving meal
                dismiss()
            
            }, label: {
                Text("Add Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
//                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color(.green), in: .rect(cornerRadius: 10))
            })
            .disabled(exercise.reps == 0)
            .opacity(exercise.reps == 0 ? 0.5 : 1)
        })
        .padding(15)
    }
}

@available(iOS 17.0, *)
#Preview {
    HomeView()
        .modelContainer(for: [Meal.self], inMemory: true)

}
