//
//  SettingsView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct SettingsView: View {
    @Query private var settings: [Settings]

    var body: some View {
        printv("settings: \(settings)")
        NavigationStack {
            List {
                Section {

                } header : {
                    Text("Biometrics")
                }
            }
            .navigationTitle("Settings")
            .toolbarBackground(.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


@available(iOS 17.0, *)
#Preview {
   SettingsView()
}

