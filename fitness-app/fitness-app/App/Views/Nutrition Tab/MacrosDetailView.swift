//
//  MacrosDetailView.swift
//  Dawn
//
//  Created by Elias on 14/09/2023.
//

import SwiftUI
import Charts
import SwiftData

@available(iOS 17.0, *)
struct MacrosDetailView: View {
    @ObservedObject var vm = NutritionViewModel()
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    @State private var macro: String = "Protein"
    @State private var macros = ["Carbs", "Fat", "Protein"]
    
    var body: some View {
        if vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).isEmpty {
            Text("Track your macros here.")
        } else {
//            Text("Your protein intake ") + Text("\(vm.macrosProgressString()!)").bold() + Text(" compared to last week!")
            Text("Track your macros here.")

        }
    
        VStack(content: {
            if vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).isEmpty {
//                Chart {
//                    ForEach(preloadedData , id: \.self) { item in
//                        AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
//                        .foregroundStyle(Color.teal.gradient)}
//                }
//                .frame(height: 70)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
            } else {
                Chart {
                    ForEach(vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                        AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                        .foregroundStyle(Color.teal.gradient)}
                }
                .frame(height: 70)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
            }
        })
           
        }
}

//#Preview {
//    MacrosDetailView()
//}
