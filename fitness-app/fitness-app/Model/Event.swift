//
//  Event.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI
import SwiftData

//struct Meal: Identifiable {
//    var id: UUID = .init()
//    var title: String
//    var calories: Int
//    var carbs: Int
//    var sugar: Int
//    var protein: Int
//    var fat: Int
//    var creationDate: Date = .init()
//    var tint: Color
//}
//
//var sampleMeals: [Meal] = [
//    .init(title: "Chicken", calories: 500, carbs: 30, sugar: 40, protein: 40, fat: 0, creationDate: .updateHour(-5), tint: .white),
//    .init(title: "Rice", calories: 700, carbs: 30, sugar: 440, protein: 50, fat: 30, creationDate: .updateHour(-3), tint: .blue),
//    .init(title: "Potato", calories: 600, carbs: 300, sugar: 40, protein: 60, fat: 40, creationDate: .updateHour(1), tint: .green),
//    .init(title: "Potato", calories: 600, carbs: 300, sugar: 40, protein: 60, fat: 40, creationDate: .updateHour(1), tint: .green),
//    .init(title: "Potato", calories: 600, carbs: 300, sugar: 40, protein: 60, fat: 40, creationDate: .updateHour(1), tint: .green),
//    .init(title: "AAAAAAA", calories: 640, carbs: 40, sugar: 0, protein: 30, fat: 45, creationDate: .updateHour(2), tint: .indigo)
//]

@available(iOS 16.4, *)
@available(iOS 17.0, *)
@Model


    class Meal: Identifiable {
        var id: UUID
        var title: String
//        var calories: Int
        var creationDate: Date
        var tint: String
        
        init(id: UUID = .init(), title: String, creationDate: Date = .init(), tint: String) {
            self.id = id
            self.title = title
//            self.calories = calories
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


extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
