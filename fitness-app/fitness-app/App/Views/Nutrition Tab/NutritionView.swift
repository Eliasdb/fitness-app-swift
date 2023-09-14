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
struct NutritionView: View {
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
    struct Datar: Hashable {
   var type: Int

       var amount: Int
    }
    var x: [Datar] = [Datar(type: 1, amount:60), Datar(type: 2, amount:80), Datar(type: 3, amount:100), Datar(type: 4, amount:40), Datar(type:5, amount:20), Datar(type:6, amount:50), Datar(type:7, amount:70)]

    

//    init() {
//        self.today = today
//        // predicate
//        let calendar = Calendar.current
//        let startOfDate = calendar.startOfDay(for: today)
//        let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
//        let predicate = #Predicate<Meal> {
//            return $0.creationDate < today && $0.creationDate > todayminus30
//        }
////         sorting
//        let sortDescriptor = [
//            SortDescriptor(\Meal.creationDate, order: .reverse)
//        ]
//        
//        self._mealsPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
//    }
    

        var body: some View {
            VStack {
        
                    NavigationStack {
                   
                           
                                CaloriesDetailView()
                         
                  
                        
                    }
                 
                
                Spacer()
            
            }   .navigationTitle("Nutrition")
                .toolbarBackground(.mint, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                       
        }
    }
    
//

