//
//  ContentView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    
    var body: some View {
        TabView {
            Group {
                CaloriesView()
                    .tabItem {
                        Label("Calories", systemImage: "fork.knife")
                    }
                ExercisesView()
                    .tabItem {
                        Label("Exercises", systemImage: "dumbbell")
                    }
                HealthView()
                    .tabItem {
                        Label("Health", systemImage: "waveform.path.ecg")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                  
        }
        .onAppear {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 5) {
                    launchScreenManager.dismiss()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenManager())
    }
}

