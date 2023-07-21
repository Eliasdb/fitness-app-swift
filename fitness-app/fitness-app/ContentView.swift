//
//  ContentView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var selection = 3

    var body: some View {
        TabView(selection: $selection) {
            Group {
                CaloriesView()
                    .tag(1)
                    .tabItem {
                        Label("Calories", systemImage: "fork.knife")
                    }
                ExercisesView()
                    .tag(2)
                    .tabItem {
                        Label("Exercises", systemImage: "dumbbell")
                    }
                HomeView()
                    .tag(3)
                    .tabItem {
                        Image("house")
                        Label("", systemImage: "sunrise.circle")
                    }
                HealthView()
                    .tag(4)
                    .tabItem {
                        Label("Health", systemImage: "waveform.path.ecg")
                    }
                SettingsView()
                    .tag(5)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
                    .toolbarBackground(.visible, for: .tabBar)
//                  .toolbarBackground(.brown, for: .tabBar)
                    .toolbarColorScheme(.light, for: .tabBar)
                  
        }
        .onAppear {
            DispatchQueue
        .main
        .asyncAfter(deadline: .now() + 5) {
            launchScreenManager.dismiss()
        }
}    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenManager())
    }
}

