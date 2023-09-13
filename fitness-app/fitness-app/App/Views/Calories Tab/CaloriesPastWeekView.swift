//
//  CaloriesPastWeekView.swift
//  Dawn
//
//  Created by Elias on 08/09/2023.
//

import SwiftUI
import Charts
import Foundation
import _SwiftData_SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

@available(iOS 17.0, *)
struct CaloriesPastWeekView: View {
    
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    var weekSlider: [[Date.WeekDay]] = []
    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate < today && $0.creationDate > todayminus30
        }
        
//         sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .reverse)
        ]
        
        self._mealsPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    struct Data: Hashable {
   var  date: String
        var  dateasDate: Date
    var amount: Int
    }
    
    func mealChartData () -> [Data]  {
        var mealsArray: [Data] = []
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        let groupedMeals = Dictionary(grouping: mealsPastWeek, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}

        let sequence = zip(groupedMealsKeys, groupedMealsValues)
        for (el1, el2) in sequence {
            mealsArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }
        
        let sortedMeals = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)})
        
        print("sortedarr: \(sortedMeals)")

        return sortedMeals
        }
    
    func getAverage (meals: [Meal]) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
        
        if (groupedMeals.isEmpty) {
            return 0
        }
        
        let average = ((groupedMealsValues.reduce(0, +) / (groupedMealsValues.count)) )
        
        return average
    }
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("<-")
        })
        
        Button(action: {
            
        }, label: {
            Text("->")
        })
        printv(mealChartData())
//        ForEach(x(), id: \.self) { item in
//            Text(item)
//        }
        Text("")
        VStack(alignment: .leading, spacing: 4, content: {
            Text("Weekly average")
            Text("\(getAverage(meals: mealsPastWeek)) kcal")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            Chart {
                RuleMark(y: .value("Goal", 3000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .trailing) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                ForEach(mealChartData(), id: \.self) { item in
                    
                    BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
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
