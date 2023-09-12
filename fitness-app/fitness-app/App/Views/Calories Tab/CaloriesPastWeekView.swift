//
//  CaloriesPastWeekView.swift
//  Dawn
//
//  Created by Elias on 08/09/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
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
    
    struct Data {
   var  date: String
    var amount: Int
    }
    

    
    func x ()  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
//        let groupedMealsValues =  mealsPastWeek.sorted( by: { $0.creationDate > $1.creationDate }).map { $0.calories }

        
        let mealperWeek = mealsPastWeek.map{ dateFormatter.string(from: $0.creationDate) }

        let mealKeys =  Set(mealperWeek)
            .compactMap { item in dateFormatter.date(from: item)}
            .sorted(by: >)
        
        print("Dates array: \(mealKeys)")

                let groupedMeals = Dictionary(grouping: mealsPastWeek, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}

//        let groupedMeals = Dictionary(grouping: mealsPastWeek, by: { dateFormatter.string(from: $0.creationDate) })


        print("groupedMeals: \(groupedMeals.sorted( by: { $0.key > $1.key }))")

        
        print("groupedMealsValues: \(groupedMealsValues)")

//
//        let mealsDictionary = Dictionary(uniqueKeysWithValues: zip(mealKeys, groupedMealsValues));
//        let sortedMealsDictionary = mealsDictionary.sorted( by: { $0.0 > $1.0 }).chunked(into: 7)
//        print("sortedMealsDictionary: \(sortedMealsDictionary)")
        
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
        let sortedMealsDictionary = mealsDictionary.sorted( by: { $0 < $1 })

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
        Button(action: {
            
        }, label: {
            Text("<-")
        })
        
        Button(action: {
            
        }, label: {
            Text("->")
        })
        printv(x())
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
                RuleMark(x: .value("Goal", 3000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .trailing) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
//                ForEach(x()[0], id: \.value) { item in
//                    BarMark(x: .value("amount", item.value), y: .value("month", item.key))
//                    .foregroundStyle(Color.accentColor.gradient)}
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
