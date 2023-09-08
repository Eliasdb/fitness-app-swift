//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI
import Foundation
import Collections


@available(iOS 17.0, *)
struct CaloriesView: View {
    
    @Query private var meals: [Meal]
    init() {
//         sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .forward)
        ]
        
        self._meals = Query(sort: sortDescriptor, animation: .snappy)
    }
    
    
    func mealChartData () -> Array<(key: String, value: Int)>  {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        
        // groups by date in dictionary and pulls out keys and values
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.calories }.reduce(0, +)}
        
        let mealsDictionary = Dictionary(uniqueKeysWithValues: zip(groupedMealsKeys, groupedMealsValues));
        let sortedMealsDictionary = mealsDictionary.sorted( by: { $0.0 < $1.0 })
        
//        let orderedDict =  OrderedDictionary(uniqueKeys: mealsDictionary.keys, values: mealsDictionary.values)

        return sortedMealsDictionary
        
        }
    
        var body: some View {
            NavigationStack {
                Section {
                    Chart(mealChartData(), id: \.key) { dataPoint in
                        LineMark(x: .value("month", dataPoint.key), y: .value("amount", dataPoint.value))
                    }
                }
                .padding(20)
//                .frame(width: 200)
            }
        }
    }
    
    
@available(iOS 17.0, *)
struct CaloriesView_Previews: PreviewProvider {
        static var previews: some View {
            CaloriesView()
        }
    }

