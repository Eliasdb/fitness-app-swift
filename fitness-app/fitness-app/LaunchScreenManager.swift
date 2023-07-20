//
//  LaunchScreenManager.swift
//  fitness-app
//
//  Created by Elias on 20/07/2023.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}

final class LaunchScreenManager: ObservableObject {
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss() {
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.state = .completed
        }
    }
}
