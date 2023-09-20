//
//  ViewModel.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import Foundation


@available(iOS 17.0, *)
class NutritionViewModel: ObservableObject {
    // declare as a property
    let func1: () -> Void = {
        print("func1")
    }

    // declare as a `func`
    func func2() {
        print("func2")
    }
    
    struct MealData: Hashable {
       var  date: String
       var  dateasDate: Date
       var amount: Int
   }
    
    struct WeightData: Hashable {
        var date: String
        var dateasDate: Date
        var amount: Double
    }

    func mealChartData (meals: [Meal]) -> [[MealData]]  {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var mealsArray: [MealData] = []
        
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
        let sequence = zip(groupedMealsKeys, groupedMealsValues)
        
        for (el1, el2) in sequence {
            mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }
        
        let sortedMeals = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
        
        return sortedMeals
        }
    

    func mealDonutChartData (meals: [Meal], macro: String) ->  [[MealData]]   {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        var mealsArray: [MealData] = []
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }

        if macro == "Protein" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.protein }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Carbs" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.carbs }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Fat" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.fat }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro

        }
        
        if (meals.isEmpty) {
            return [[]]
        }
        
        return [[]]
    }
    
    func getMacrosAverage (meals: [MealData]) -> Int {
        let allCalories = meals.map {$0.amount}.reduce(0, +)
        let numberOfMeals = meals.count
        
        
        if (meals.isEmpty) {
            return 0
        }
        
        let average = allCalories / numberOfMeals

        return average
    }
    
    func getAverage (meals: [MealData]) -> Int {
       let allCalories = meals.map {$0.amount}.reduce(0, +)
       let numberOfMeals = meals.count
       
       let average = allCalories / numberOfMeals
       
       if (meals.isEmpty) {
           return 0
       }
       return average
   }
    
   
    
    func getDateString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func getWeights (weights: [Weight]) -> [WeightData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var weightsArray: [WeightData] = []

        let groupedWeights = Dictionary(grouping: weights, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedWeightsKeys =  groupedWeights.map { $0.key }
        let groupedWeightsValues =  groupedWeights.map { $0.value.map { $0.weight }.last}
//        print(groupedWeightsValues)
        let sequence = zip(groupedWeightsKeys, groupedWeightsValues)
        for (el1, el2) in sequence {
            weightsArray.append( WeightData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2!))
        }
        let sortedWeights = weightsArray.sorted(by: { $0.dateasDate < ($1.dateasDate)})
        return sortedWeights
    }
    
    func caloriesProgressString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        
//        if mealChartData(meals: mealsPastWeek)[weekIndex]. {
//            return ""
//        }
//
////        if mealChartData(meals: mealsPastWeek)[]
//
//
//        let totalCaloriesThisWeek: Int = mealChartData(meals: mealsPastWeek)[0].map { $0.amount }.reduce(0,+)
//
//        let totalCaloriesLastWeek: Int = mealChartData(meals: mealsPastWeek)[1].map { $0.amount }.reduce(0,+)
//        print(totalCaloriesLastWeek)
//
//        print(totalCaloriesThisWeek)
//
//        let percentage: Double = (Double(totalCaloriesThisWeek) - Double(totalCaloriesLastWeek)) / Double(totalCaloriesThisWeek)
//        guard let formattedPercentage = numberFormatter.string(from: NSNumber(value: abs(percentage)
//                                                                             ))
//        else {
//            return nil }
//
//        let description: String = percentage < 0 ? "decreased by" : "increased by"
//
//        return "\(description) \(formattedPercentage)"
        return "To be fixed"
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
    

}
