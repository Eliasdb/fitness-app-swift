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


@available(iOS 17.0, *)
struct CaloriesView: View {
//    private static let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
    
//    struct ChartData: Identifiable, Equatable {
//        var id: String { return day }
//        let day: Date
//        let amount: Int
//    }
    
//    @Binding var currentDate: Date
    // swiftdata dynamic query

    @Query private var meals: [Meal]
    
    init() {
//        self._currentDate = currentDate
//        // predicate
//        let calendar = Calendar.current
//        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
//        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
//        let predicate = #Predicate<Meal> {
//            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
//        }
        
        // sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .forward)
        ]
        self._meals = Query(sort: sortDescriptor, animation: .snappy)
    }
    
    var data: [(day: Date?, amount: Int?)] {
        [(day: meals.first?.creationDate, amount: meals.first?.calories),
         (day: meals.last?.creationDate, amount: meals.last?.calories)
          ]
    }
    
    func dateFormatter (date: Date) -> String {
            let dateFormatter = DateFormatter();
            dateFormatter.dateFormat = "EEEE";
            let monthString = dateFormatter.string(from: date);
        return monthString
    }

    var body: some View {
        NavigationStack {
            Section {
                Chart(meals, id: \.id) { dataPoint in
                    LineMark(x: .value("month", dateFormatter(date: dataPoint.creationDate)), y: .value("amount", dataPoint.calories))
                }
            }
            .padding(20)
        }
    }
}
   

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 17.0, *) {
            HomeView()
        } else {
            // Fallback on earlier versions
        }
    }
}
