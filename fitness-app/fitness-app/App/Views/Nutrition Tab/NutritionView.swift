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
import PhotosUI

@available(iOS 17.0, *)
struct NutritionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var vm = NutritionViewModel()

    @Query private var mealsPastWeek: [Meal]
    @Query private var weights: [Weight]
    
    @State private var calendarId: Int = 0
    @State private var today: Date = .init()
    @State private var weekIndexCalories: Int = 0
    @State private var weekIndexMacros: Int = 0
    @State private var weight: Double = 0.0
    @State private var macro: String = ""
    @State private var weightDay: Date = Date()
    @State private var currentDateString: String = ""

    var macros = ["Carbs", "Fat", "Protein"]

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
            List {
                CaloriesPastWeekView(weekIndexCalories: $weekIndexCalories)
                
                MacrosPastWeekView(weekIndexMacros: $weekIndexMacros)
                
                WeightTrackerView(weightDay: $weightDay, weight: $weight)
                
            }.navigationTitle("Nutrition")
                .toolbarBackground(.mint, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//@available(iOS 17.0, *)
//#Preview {
//        NutritionView()
//}

