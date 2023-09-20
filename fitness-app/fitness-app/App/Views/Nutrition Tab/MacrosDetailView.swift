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
    @ObservedObject var vm = ViewModel()
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    @State private var macro: String = "Protein"
    @State private var macros = ["Carbs", "Fat", "Protein"]
    
    struct Data: Hashable {
        var  date: String
        var  dateasDate: Date
        var amount: Int
    }

    init() {
            self.today = today
            // predicate
            let calendar = Calendar.current
            let startOfDate = calendar.startOfDay(for: today)
            let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
            let predicate = #Predicate<Meal> {
                return $0.creationDate < today && $0.creationDate > todayminus30
            }
                  let sortDescriptor = [
                      SortDescriptor(\Meal.creationDate, order: .reverse)
                  ]
                self._mealsPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
        }
    
    func macrosProgressString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
//        if mealDonutChartData(meals: mealsPastWeek).isEmpty {
//            return ""
//        }
//        if macro == "Protein" {
//            let totalProteinLastWeek: Int = mealDonutChartData(meals: mealsPastWeek)[1].map { $0.amount }.reduce(0,+)
//
//            let totalProteinThisWeek = mealDonutChartData(meals: mealsPastWeek)[0].map { $0.amount }.reduce(0,+)
//            let percentage: Double = (Double(totalProteinThisWeek) - Double(totalProteinLastWeek)) / Double(totalProteinThisWeek)
//            guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: abs(percentage)
//                                                                                 ))
//            else {
//                return nil }
//
//            let description: String = percentage < 0 ? "is down by" : "is up by"
//
//            return "\(description) \(formattedPercentage)"
//        }

        
        return ""
    }
  
    var body: some View {
        if vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).isEmpty {
            Text("Track your macros here.")
        } else {
            Text("Your protein intake ") + Text("\(macrosProgressString()!)").bold() + Text(" compared to last week!")
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
