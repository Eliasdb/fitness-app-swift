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

    @Query private var calorieCounter: [Count]
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Count> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        
        // sorting
//        let sortDescriptor = [
//            SortDescriptor(\Count.creationDate, order: .reverse)
//        ]
        self._calorieCounter = Query(filter: predicate, animation: .snappy)

    }
    
    
//    mutating func nop(number: Int) -> Void {
//        ForEach(calorieCounter) { item in
//            counter.append(number)
//
// //           Text("\(item.number)")
// //           counter.append(item.number)
//
//        }
//        
//    }
//


    var body: some View {
        
        if (calorieCounter.last?.number) != nil {
            Text("\(String(describing: calorieCounter.last!.number))/3000 calories")
                .padding(15)
        }
    }
}

//#Preview {
//    CalorieCounterView()
//}
