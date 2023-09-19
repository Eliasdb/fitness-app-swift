//
//  ExercisesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct ExercisesView: View {
    @Query private var exercisesPastWeek: [Exercise]
    @Query private var photos: [Photo]

    @State private var today: Date = .init()
    @State private var exercise: String = "Plank"
    @State private var category: String = "Abs"
    @State private var weekIndex: Int = 0
    
    @State private var createNewPhoto: Bool = false
    var categoriesString: [String] = ["Abs", "Arms", "Back", "Chest", "Legs"]

    @State private var selectedPhotoCategory: String = ""

    
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
        let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
        let predicate = #Predicate<Exercise> {
            return $0.creationDate <= startOfDate && $0.creationDate > todayminus30
        }
        
//         sorting
        let sortDescriptor = [
            
            SortDescriptor(\Exercise.creationDate, order: .forward)
        ]
        
        self._exercisesPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    struct Data: Hashable {
        var  date: String
        var  dateasDate: Date
        var amount: Int
    }
    
    func exerciseChartData (exercises: [Exercise]) -> [[Data]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var exercisesArray: [Data] = []

        let groupedExercisesbyDate = Dictionary(grouping: exercises.filter{$0.category.contains(category)}.filter{$0.title.contains(exercise)}, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedExercisesKeys =  groupedExercisesbyDate.map { $0.key }
        let groupedExercisesValues =  groupedExercisesbyDate.map { $0.value.map {$0.totalAmount}.reduce(0, +)}
        let sequence = zip(groupedExercisesKeys, groupedExercisesValues)

        for (el1, el2) in sequence {
            exercisesArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }

        let sortedExercises = exercisesArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
        
        if sortedExercises.isEmpty {
            return [[]]
        }

        
        return sortedExercises
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
      
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        List {
                            Section {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    HStack(content: {
                                        Button(action: {
                                            weekIndex+=1
                                            
                                            if weekIndex >= exerciseChartData(exercises: exercisesPastWeek).count {
                                                weekIndex = 0
                                            }
                                        }, label: {
                                            Image(systemName: "chevron.left").foregroundStyle(Color("TestColor"))
                                        }).buttonStyle(BorderlessButtonStyle())
                                        Spacer()
                                        if exerciseChartData(exercises: exercisesPastWeek)[weekIndex].isEmpty {
                                            Text("No data yet.")
                                                .font(.footnote)
                                                .foregroundStyle(Color("TestColor"))
                                                .fontWeight(.bold)
                                        } else if !exerciseChartData(exercises: exercisesPastWeek)[weekIndex].isEmpty {
                                            Text("\(String(describing: exerciseChartData(exercises: exercisesPastWeek)[weekIndex].last!.date)) - \(String(describing: exerciseChartData(exercises: exercisesPastWeek)[weekIndex].first!.date))")
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
                                            ForEach(exerciseChartData(exercises: exercisesPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
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
                Section {
                    NavigationLink {
                        VStack(alignment: .center, spacing: 0, content: {
                            Picker("", selection: $selectedPhotoCategory){
                                ForEach(categoriesString, id: \.self) { item in
                                    Text("\(item)")                                        .tag(item)
                                }
                            }

                            Section {
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(photos) { item in
                                            ZStack(alignment: .bottom) {
                                                Image(uiImage: UIImage(data: item.image!)!)
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(minWidth: 300, maxHeight
                                                               : 400)

                                                VStack(spacing: 0) {
                                                    Rectangle()
                                                        .fill(.white)
                                                        .frame(height: 3)

                                                    HStack(alignment: .top) {
                                                        VStack(alignment: .leading) {
                                                            Text("\(item.imageCategory)")

                                                            Text("\(item.creationDate)")
                                                                .font(.body)
                                                        }

                                                        Spacer()

                                                    
                                                    }
                                                    .font(.title3.bold())
                                                    .padding(10)
                                                    .padding(.horizontal, 10)
                                                    .background(.mint)
                                                    .foregroundStyle(.black)
                                                    .frame(maxWidth: .infinity)
                                                }
                                            }
                                           
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .shadow(color: .black.opacity(0.2), radius: 2)
                                            .padding(4)
                                            .containerRelativeFrame(.horizontal)
                                        }
                                    }
                                        .scrollTargetLayout()
                                    
                                }.scrollIndicators(.hidden)
                                    .scrollTargetBehavior(.viewAligned)
                                    .contentMargins(20, for: .scrollContent)
                                    .listRowInsets(EdgeInsets())
                            }
                        }).overlay(alignment: .bottomTrailing, content: {
                            VStack {
                                Button(action: {
                                    createNewPhoto.toggle()
                                }, label: {
                                    Image(systemName: "plus")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(width: 55, height: 55)
                                        .background(.indigo.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10 )), in: .circle)
                                })
                                .padding(15)
                                .offset(y:70)
                                
                                
                            }
                         
                        })
                      
                        .sheet(isPresented: $createNewPhoto, content: {
                            AddPhotoView()
                                .presentationDetents([.height(520)])
                                .interactiveDismissDisabled()
                                .presentationCornerRadius(30)
                                .presentationBackground(.white)
                        })

                    } label : {
                        PhotoGalleryDetailView()
                    }
                }

                
            }   .navigationTitle("Exercises")
                .toolbarBackground(.mint, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

@available(iOS 17.0, *)
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
