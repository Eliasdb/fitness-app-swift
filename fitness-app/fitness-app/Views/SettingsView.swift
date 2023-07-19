//
//  SettingsView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Test")
                }
               
            }
            .navigationTitle("Settings")
            .toolbarBackground(.white, for: .navigationBar)
          
        }
           
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
