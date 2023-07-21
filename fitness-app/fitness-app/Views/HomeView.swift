//
//  HomeView.swift
//  fitness-app
//
//  Created by Elias on 20/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {

        NavigationStack {
            Form {
                Section {
                    
                }
            }
            .navigationTitle("Home")
            .toolbarBackground(.cyan, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
      

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
