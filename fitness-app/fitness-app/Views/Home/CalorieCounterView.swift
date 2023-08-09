//
//  CalorieCounterView.swift
//  Dawn
//
//  Created by Elias on 02/08/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct CalorieCounterView: View {
    @Binding var currentDate: Date
    
    @Query private var meals: [Meal]
    @Query private var calorieCounter: [Count]
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        
        // sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .reverse)
        ]
        self._meals = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
        self._currentDate = currentDate
        // predicate
        let predicate2 = #Predicate<Count> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }

        self._calorieCounter = Query(filter: predicate2, animation: .snappy)
    }
    
    var body: some View {
        
//        if (calorieCounter.last?.number) != nil {
//             let numberArray = calorieCounter.map { $0.number }
//            Text("\(String(describing: numberArray.reduce(0, +)))/3000 calories")
//                .padding(15)
//        }
        if (meals.isEmpty != true) {
            let numArray = meals.map {$0.calories}
            Text("\(String(describing: numArray.reduce(0, +)))/3000 calories")
        }

    }
}

//#Preview {
//    CalorieCounterView()
//}
