//
//  HealthView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct HealthView: View {

    var body: some View {
        NavigationStack {
            Form {
                Section {
                }
            }
            .navigationTitle("Health")
            .toolbarBackground(.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//   HealthView()
//}
