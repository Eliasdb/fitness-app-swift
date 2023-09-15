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
    
        @Query private var mealsPastWeek: [Meal]
        @State private var today: Date = .init()
        @State private var weekIndex: Int = 0

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
    
    func caloriesProgressString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        let totalCaloriesThisWeek: Int = mealChartData(meals: mealsPastWeek)[0].map { $0.amount }.reduce(0,+)

        let totalCaloriesLastWeek: Int = mealChartData(meals: mealsPastWeek)[1].map { $0.amount }.reduce(0,+)
        print(totalCaloriesLastWeek)

        print(totalCaloriesThisWeek)

        let percentage: Double = (Double(totalCaloriesThisWeek) - Double(totalCaloriesLastWeek)) / Double(totalCaloriesThisWeek)
        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: abs(percentage)
                                                                             ))
        else {
            return nil }

        let description: String = percentage < 0 ? "decreased by" : "increased by"

        return "\(description) \(formattedPercentage)"
    }
    
    
    var body: some View {
     
        VStack(content: {
            Text("Your calorie intake has ") + Text("\(caloriesProgressString()!)").bold() + Text(" compared to last week!")
            Chart {
                ForEach(mealChartData(meals: mealsPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                    BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
                    .foregroundStyle(Color.accentColor.gradient)}
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        })
        
    }
}

//#Preview {
//    CaloriesDetailView()
//}
