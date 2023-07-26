//
//  fitness_appApp.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct fitness_appApp: App {
    @StateObject var launchScreenManager = LaunchScreenManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if launchScreenManager.state != .completed {
                    LaunchScreenView()
                }
            }
            .environmentObject(launchScreenManager)
           
        }
        .modelContainer(for: Meal.self)
    }
}
