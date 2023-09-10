//
//  Event.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI
import SwiftData

@available(iOS 16.4, *)
@available(iOS 17.0, *)
@Model
    class Meal {
        var id: UUID
        var title: String
        var calories: Int
        var carbs: Int
        var fat: Int
        var protein: Int
        var creationDate: Date
        var tint: String
                
        init(id: UUID = .init(), title: String, calories: Int
             , carbs: Int, fat: Int, protein: Int, creationDate: Date = .init(), tint: String) {
            self.id = id
            self.title = title
            self.calories = calories
            self.carbs = carbs
            self.fat = fat
            self.protein = protein
            self.creationDate = creationDate
            self.tint = tint
        }
        
        var tintColor: Color {
            switch tint {
            case "Color 1": return Color("Color 1")
            case "Color 2": return Color("Color 2")
            case "Color 3": return Color("Color 3")
            default: return .white
            }
        }
        
    }

@available(iOS 16.4, *)
@available(iOS 17.0, *)
@Model
    class Exercise {
        var id: UUID
        var category: String
        var title: String
        var sets: Int
        var reps: Int
        var minutes : Int?
        var creationDate: Date
                
        init(id: UUID = .init(), title: String, category: String
             , sets: Int, reps: Int, minutes: Int, creationDate: Date = .init()) {
            self.id = id
            self.category = category
            self.title = title
            self.sets = sets
            self.reps = reps
            self.minutes = minutes
            self.creationDate = creationDate
        }
    }


extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
