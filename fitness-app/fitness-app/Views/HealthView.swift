//
//  HealthView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct HealthView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Test")
                }
               
            }
            .navigationTitle("Health")
            .toolbarBackground(.white, for: .navigationBar)
          
        }
           
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
