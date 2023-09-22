//
//  Settings.swift
//  Dawn
//
//  Created by Elias on 22/09/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@Model
class Settings {
        var name: String
        var age: Int
        var weight: Double
        var height: Int
        var sex: String
        var kcalGoal: Int
        var pGoal: Int
    
    init(name: String, age: Int, weight: Double, height: Int, sex: String, kcalGoal: Int, pGoal: Int ) {
            self.name = name
            self.age = age
            self.weight = weight
            self.height = height
            self.sex = sex
            self.kcalGoal = kcalGoal
            self.pGoal = pGoal
        }
    }
