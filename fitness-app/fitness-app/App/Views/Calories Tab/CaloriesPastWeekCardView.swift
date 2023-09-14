//
//  CaloriesPastWeekCardView.swift
//  Dawn
//
//  Created by Elias on 14/09/2023.
//


import SwiftUI
import Charts
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct CaloriesPastWeekCardView: View {
    
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    
    
    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -7, to: startOfDate)!
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
    
    func mealChartData (meals: [Meal]) -> [Data]  {
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
        
        let sortedMeals = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)})
        
        return sortedMeals
    }
    
    var body: some View {
            VStack {
//                Chart {
//                    ForEach(x, id: \.self) { item in
//                        BarMark(x: .value("day", item.type), y: .value("amount", item.amount))
//                        .foregroundStyle(Color.accentColor.gradient)
//                    }
//                }
//                .padding(30)
//                .frame(height: 70)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
            }
        
   
    }
    
}


//#Preview {
//    if #available(iOS 17.0, *) {
//        CaloriesPastWeekView()
//    } else {
//        // Fallback on earlier versions
//    }
//}
