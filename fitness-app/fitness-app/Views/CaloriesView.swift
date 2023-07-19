//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct CaloriesView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Test")
                    Text("Test")
                    Text("Test")
                    Text("Test")
                    Text("Test")
                    Text("Test")
                    Text("Test")
                    Text("Test")
                }
               
            }
         
            .navigationTitle("Calories Tracker")
            .toolbarBackground(.white, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView()
    }
}
