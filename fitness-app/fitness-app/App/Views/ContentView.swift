//
//  ContentView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    @EnvironmentObject var launchScreenManager: LaunchScreenManager
    @State private var selection = 3
    @State private var categories: [String : [(name: String, sets: Int, reps: Int)]] =
    ["Abs":
            [(name: "Plank", sets: 0, reps: 0),
             (name: "Bicycle Crunch", sets: 0, reps: 0),
             (name: "Hollow hold", sets: 0, reps: 0),
             (name: "Bird dog exercise", sets: 0, reps: 0),
             (name: "Bicep dumbbell curl", sets: 0, reps: 0)],
     
     "Arms":
            [(name: "Bicep dumbbell curl", sets: 0, reps: 0),
             (name: "Overhead Triceps Extension", sets: 0, reps: 0)],
     
     "Back":
            [(name: "One-arm dumbbell row", sets: 0, reps: 0),
              (name: "Bridge", sets: 0, reps: 0)],
     
     "Chest":
            [(name: "Push ups", sets: 0, reps: 0),
            (name: "Dumbbell bench press", sets: 0, reps: 0)],
     
     "Legs":
            [(name: "Deadlift", sets: 0, reps: 0),
            (name: "Bodyweight Squat", sets: 0, reps: 0)]
    ]


    
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
                HomeView(categories: $categories)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.green)
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
//          .toolbarBackground(.brown, for: .tabBar)
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

@available(iOS 17.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenManager())
            .modelContainer(for: [Meal.self, Exercise.self], inMemory: true)

    }
}
