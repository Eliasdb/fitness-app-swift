//
//  SettingsView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct SettingsView: View {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
//    @Binding var proteinAmount: Int
    
    var body: some View {
        NavigationStack {
            List {
                Section {
//                    TextField("Protein", value: $proteinAmount, formatter: Self.formatter)
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

extension Binding {
    public static func variable(_ proteinAmount: Int) -> Binding<Int> {
        var state = proteinAmount
        return Binding<Int> {
            state
        } set: {
            state = $0
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
