//
//  Event.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI

struct Meal: Identifiable {
    var id: UUID = .init()
    var title: String
    var calories: Int
    var carbs: Int
    var sugar: Int
    var protein: Int
    var fat: Int
    var creationDate: Date = .init()
    var tint: Color
}

var sampleMeals: [Meal] = [
    .init(title: "Chicken", calories: 500, carbs: 30, sugar: 40, protein: 40, fat: 0, creationDate: .updateHour(-5), tint: .white),
    .init(title: "Rice", calories: 700, carbs: 30, sugar: 440, protein: 50, fat: 30, creationDate: .updateHour(-3), tint: .blue),
    .init(title: "Potato", calories: 600, carbs: 300, sugar: 40, protein: 60, fat: 40, creationDate: .updateHour(1), tint: .green)

]

extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
