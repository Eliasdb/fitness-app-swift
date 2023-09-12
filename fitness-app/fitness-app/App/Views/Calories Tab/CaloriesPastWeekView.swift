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
struct CaloriesPastWeekView: View {
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()

    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -7, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate <= startOfDate && $0.creationDate > todayminus30
        }
        
//         sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .forward)
        ]
        
        self._mealsPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    func mealChartData () -> Array<(key: String, value: Int)>  {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        // groups by date in dictionary and pulls out keys and values
        let groupedMeals = Dictionary(grouping: mealsPastWeek, by: { dateFormatter.string(from: $0.creationDate) })

        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
        
        let mealsDictionary = Dictionary(uniqueKeysWithValues: zip(groupedMealsKeys, groupedMealsValues));
        print(mealsDictionary)
        let sortedMealsDictionary = mealsDictionary.sorted( by: { $0.0 < $1.0 })
        
        return sortedMealsDictionary
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
        VStack(alignment: .leading, spacing: 4, content: {
            Text("Weekly average")
            Text("\(getAverage(meals: mealsPastWeek)) kcal")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            Chart {
                RuleMark(x: .value("Goal", 3000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .trailing) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                ForEach(mealChartData(), id: \.value) { item in
                    BarMark(x: .value("amount", item.value), y: .value("month", item.key))
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
