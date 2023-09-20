//
//  SettingsView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section {
//
                } header : {
                    Text("Goals")
                }
            }
            .navigationTitle("Settings")
            .toolbarBackground(.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


//@available(iOS 17.0, *)
//#Preview {
//   SettingsView()
//}

