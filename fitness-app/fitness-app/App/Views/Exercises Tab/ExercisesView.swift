//
//  ExercisesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct ExercisesView: View {
    @Query private var exercisesPastWeek: [Exercise]
    @Query private var photos: [Photo]
    @ObservedObject var vm = ExercisesViewModel()

    @State private var today: Date = .init()
    @State private var exercise: String = "Plank"
    @State private var category: String = "Abs"
    @State private var weekIndex: Int = 0
    @State private var createNewPhoto: Bool = false
    @State private var selectedPhotoCategory: String = "Abs"
    @State private var categoriesString: [String] = ["Abs", "Arms", "Back", "Chest", "Legs"]
   
    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
        let predicate = #Predicate<Exercise> {
            return $0.creationDate <= startOfDate && $0.creationDate > todayminus30
        }
//         sorting
        let sortDescriptor = [
            
            SortDescriptor(\Exercise.creationDate, order: .forward)
        ]
        
        self._exercisesPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ExercisesPastWeekView(exercise: $exercise, category: $category, weekIndex: $weekIndex)
                
                PhotoGalleryView(selectedPhotoCategory: $selectedPhotoCategory, categoriesString: $categoriesString, createNewPhoto: $createNewPhoto)
                
            }
            .navigationTitle("Exercises")
            .toolbarBackground(.mint, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//   ExercisesView()
//}
