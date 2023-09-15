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
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    @State private var macro: String = "Fat"
    
    
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

   
    
    func mealDonutChartData (meals: [Meal]) ->  [[Data]]   {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        
        var mealsArray: [Data] = []
        
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
    
        
       
        let groupedMealsKeys =  groupedMeals.map { $0.key }

        if macro == "Protein" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.protein }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Carbs" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.carbs }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Fat" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.fat }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro

        }
        
        if (meals.isEmpty) {
            return [[]]
        }
        

        return [[]]
    }
    
    func getAverage (meals: [Data]) -> Int {
        let allCalories = meals.map {$0.amount}.reduce(0, +)
        let numberOfMeals = meals.count
        
        
        if (meals.isEmpty) {
            return 0
        }
        
        let average = allCalories / numberOfMeals

        return average
    }
    
    var body: some View {
        VStack(content: {
            Text("Macros history")
            Chart {
                ForEach(mealDonutChartData(meals: mealsPastWeek)[weekIndex].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                    AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                    .foregroundStyle(Color.teal.gradient)}
            }
            .frame(height: 70)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        })
           
        }
}

//#Preview {
//    MacrosDetailView()
//}
