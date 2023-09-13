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
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
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
    
        var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    Form {
                        Section {
                            CaloriesPastWeekView()
                        }
                        Section {
                            MacrosPastWeekView()
                        }
                       
                    }
                }
                .navigationTitle("Calories")
                .toolbarBackground(.yellow, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    
@available(iOS 17.0, *)
struct CaloriesView_Previews: PreviewProvider {
        static var previews: some View {
            CaloriesView()
        }
    }

