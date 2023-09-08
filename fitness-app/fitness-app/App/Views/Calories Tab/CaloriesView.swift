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

struct meal: Identifiable {
let id: UUID
let key: String
let value: Int
}
//
//extension Dictionary: Identifiable {
//    public typealias ID = Int
//    public var id: Int {
//        return hash
//    }
//}

@available(iOS 17.0, *)
struct CaloriesView: View {
    
    @State private var today: Date = .init()

    
    @Query private var meals: [Meal]
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
        
        self._meals = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
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
print(sortedMealsDictionary)
        return sortedMealsDictionary
        
        }
    
    func getAverage () -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM"
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.calories }.reduce(0, +)}
        
        let average = groupedMealsValues.reduce(0, +) / groupedMealsValues.count
        
        return average

    }
    
        var body: some View {
            NavigationStack {
                Form {
                    Section {
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("Weekly average")
                            Text("\(mealChartData().map { $0.value}.reduce(0, +) / mealChartData().map { $0.value}.count) kcal")
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
                                ForEach(mealChartData(), id: \.key) { item in
                                    BarMark(x: .value("month", item.key), y: .value("amount", item.value))
                                    .foregroundStyle(Color.accentColor.gradient)}

                            }
                            .frame(height: 180)
                            .chartXAxis {
                                AxisMarks(values: mealChartData().map { $0.key}) { key in
        //                            AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel()
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }.padding()


                        })
                    }
                   
                }
                .navigationTitle("Calories")
                .toolbarBackground(.yellow, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
     
        }
    }
    
    
@available(iOS 17.0, *)
struct CaloriesView_Previews: PreviewProvider {
        static var previews: some View {
            CaloriesView()
        }
    }

