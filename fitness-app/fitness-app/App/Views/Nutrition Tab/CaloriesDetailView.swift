//
//  CaloriesDetailView.swift
//  Dawn
//
//  Created by Elias on 14/09/2023.
//

import SwiftUI
import Charts
import SwiftData

@available(iOS 17.0, *)
struct CaloriesDetailView: View {
    @ObservedObject var vm = NutritionViewModel()
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0

    var body: some View {
        VStack(content: {
            if vm.mealChartData(meals: mealsPastWeek).isEmpty {
                Text("Track your calories here.")
            } else {
                Text("Your calorie intake has ") + Text("\(vm.caloriesProgressString()!)").bold() + Text(" compared to last week!")
            }
            
//            if vm.mealChartData(meals: mealsPastWeek).isEmpty {
//                Chart {
//                    ForEach(preloadedData, id: \.self) { item in
//                        BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
//                        .foregroundStyle(Color.accentColor.gradient)}
//                }
//                .frame(height: 70)
//                .aspectRatio(4, contentMode: .fit)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//                .chartXScale(domain: 0...6
//                )
//                
//            } else {
//                Chart {
//                    ForEach(vm.mealChartData(meals: mealsPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
//                        BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
//                        .foregroundStyle(Color.accentColor.gradient)}
//                }
//                .frame(height: 70)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//            }
        })
        
    }
}

//#Preview {
//    CaloriesDetailView()
//}
