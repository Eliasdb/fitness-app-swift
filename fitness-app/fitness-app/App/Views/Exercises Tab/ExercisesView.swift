//
//  ExercisesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct ExercisesView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Test")
                }
            }
            .navigationTitle("Exercises")
            .toolbarBackground(.mint, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
