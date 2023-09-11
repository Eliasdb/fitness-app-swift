//
//  ExercisesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ExercisesView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ExercisesPastWeekView()
                }
            }
            .navigationTitle("Exercises")
            .toolbarBackground(.mint, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

@available(iOS 17.0, *)
struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
