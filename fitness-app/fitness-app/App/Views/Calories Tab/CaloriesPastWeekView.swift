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

@available(iOS 17.0, *)
struct CaloriesPastWeekView: View {
    
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0

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
    
    func mealChartData (meals: [Meal]) -> [[Data]]  {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var mealsArray: [Data] = []
        
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
        let sequence = zip(groupedMealsKeys, groupedMealsValues)
        
        for (el1, el2) in sequence {
            mealsArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }
        
        let sortedMeals = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
        
        return sortedMeals
        }
    
    func getAverage (meals: [Data]) -> Int {
        let allCalories = meals.map {$0.amount}.reduce(0, +)
        let numberOfMeals = meals.count
        
        let average = allCalories / numberOfMeals
        
        if (meals.isEmpty) {
            return 0
        }
        return average
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            HStack(content: {
                Button(action: {
                    weekIndex+=1
                    
                    if weekIndex >= mealChartData(meals: mealsPastWeek).count {
                        weekIndex = 0
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                }).buttonStyle(BorderlessButtonStyle())
                Spacer()
                Text("\(String(describing: mealChartData(meals: mealsPastWeek)[weekIndex].last!.date)) - \(String(describing: mealChartData(meals: mealsPastWeek)[weekIndex].first!.date))")
                    .font(.footnote)
                    .foregroundStyle(.green)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    weekIndex-=1
                    
                    if weekIndex == -1 {
                        weekIndex = 0
                    }
                    
                }, label: {
                    Image(systemName: "chevron.right")
                }).buttonStyle(BorderlessButtonStyle())
            })
            .padding(.top, 20)
            Spacer()
            VStack(alignment: .leading, spacing: 4, content: {
                Text("Weekly average")
                Text("\(getAverage(meals: mealChartData(meals:mealsPastWeek)[weekIndex])) kcal")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)
            })
            Chart {
                RuleMark(y: .value("Goal", 3000))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .trailing) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                ForEach(mealChartData(meals: mealsPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                    BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
                    .foregroundStyle(Color.accentColor.gradient)}
            }
            .frame(height: 180)
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
