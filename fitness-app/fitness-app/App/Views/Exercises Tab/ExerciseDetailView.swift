//
//  ExerciseDetailView.swift
//  Dawn
//
//  Created by Elias on 15/09/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct ExerciseDetailView: View {
    @Query private var exercisesPastWeek: [Exercise]
    @State private var today: Date = .init()
    @State private var exercise: String = "Deadlift"
    @State private var category: String = "Legs"
    @State private var weekIndex: Int = 0

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
    
    func exerciseProgressInt() -> Int {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent

        let totalDeadliftRepsThisWeek: Int = exerciseChartData(exercises: exercisesPastWeek)[0].map { $0.amount }.reduce(0,+)
        
        return totalDeadliftRepsThisWeek
        
    }
    
    var body: some View {
        Text("You deadlifted a total of ") + Text("\(exerciseProgressInt()) reps").bold() + Text(" this week!")
        VStack(content: {
            Chart {
                ForEach(exerciseChartData(exercises: exercisesPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                   BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
                    .foregroundStyle(Color("TestColor").gradient)}
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        })

    }
}

//#Preview {
//    ExerciseDetailView()
//}
