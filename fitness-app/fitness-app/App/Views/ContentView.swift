//
//  ContentView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    
    @State private var firstName: String = ""
    @State private var age: Int = 0
    @State private var weight: Double = 0.0
    @State private var height: Double = 0.0
    @State private var sex: String = ""
    @State private var activityLevel: String = ""
    
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
    
    @State private var selectedIndex: Int = 2
    
    let icons = ["fork.knife", "dumbbell", "house", "waveform.path.ecg", "gearshape" ]
    
    var body: some View {
//        TabView(selection: $selection) {
//            Group {
//                NutritionView()
//                    .tag(1)
//                    .tabItem {
//                        Label("Calories", systemImage: "fork.knife")
//                    }
//                ExercisesView()
//                    .tag(2)
//                    .tabItem {
//                        Label("Exercises", systemImage: "dumbbell")
//                    }
//                HomeView(categories: $categories)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(.green)
//                    .tag(3)
//                    .tabItem {
//                        Image("house")
//                        Label("", systemImage: "sunrise.circle")
//                    } 
//                HealthView()
//                    .tag(4)
//                    .tabItem {
//                        Label("Health", systemImage: "waveform.path.ecg")
//                    }
//                SettingsView()
//                    .tag(5)
//                    .tabItem {
//                        Label("Settings", systemImage: "gearshape")
//                    }
//            }
//            .toolbarBackground(.visible, for: .tabBar)
////          .toolbarBackground(.brown, for: .tabBar)
//            .toolbarColorScheme(.dark, for: .tabBar)
//        }
        ZStack {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding, firstName: $firstName, age: $age, weight: $weight, height: $height, sex: $sex, activityLevel: $activityLevel)
                    .background(Color.white)
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        launchScreenManager.dismiss()
                    }
            } else {
                VStack {
                    ZStack {
                        switch selectedIndex {
                        case 0:  NutritionView()
                        case 1:  ExercisesView()
                        case 2:  HomeView(categories: $categories)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(.green)
                        case 3:  HealthView()
                        case 4:  SettingsView()
                        default: HomeView(categories: $categories)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                        }
                    }
                    Spacer()
                    HStack {
                        ForEach(0..<5) { num in
                            Button(action: {
                                selectedIndex = num
                            } , label: {
                                Spacer()
                                Image(systemName: icons[num])
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(Color.mint)
                                Spacer()
                            })
                        }
                    }
                }.onAppear {
                    DispatchQueue
                        .main
                        .asyncAfter(deadline: .now() + 5) {
                            launchScreenManager.dismiss()
                        }
                }
            }
        }


    }
}

//@available(iOS 17.0, *)
//#Preview {
//        ContentView()
//}


