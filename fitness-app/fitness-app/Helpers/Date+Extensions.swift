//
//  Date+Extensions.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI

extension Date {
    func format (_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    // checking if date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    // fetches week based on given date
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekforDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startofWeek = weekforDate?.start else {
            return []
        }
    
        (1..<8).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startofWeek) {
                week.append(.init(date: weekDay))
            }
        }
        return week
    }
    
    // creating next week, based on last currents week date
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    // creating previous week, based on first currents week date

    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -2, to: startOfFirstDate) else {
            return []
        }
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
}
