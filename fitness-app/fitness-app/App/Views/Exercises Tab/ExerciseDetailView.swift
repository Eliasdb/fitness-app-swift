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
    @ObservedObject var vm = ExercisesViewModel()

    @State private var today: Date = .init()
    @State private var exercise: String = "Deadlift"
    @State private var category: String = "Legs"
    @State private var weekIndex: Int = 0

    var body: some View {
//        Text("You deadlifted a total of ") + Text("\(vm.exerciseProgressInt()) reps").bold() + Text(" this week!")
        VStack(content: {
            Chart {
                ForEach(vm.exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
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
