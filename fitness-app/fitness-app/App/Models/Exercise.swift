//
//  Exercise.swift
//  Dawn
//
//  Created by Elias on 12/09/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@Model
    class Exercise {
        var id: UUID
        var category: String
        var title: String
        var sets: Int
        var reps: Int
        var totalAmount: Int
        var minutes : Int?
        var creationDate: Date
                
        init(id: UUID = .init(), title: String, category: String, sets: Int, reps: Int, totalAmount: Int, minutes: Int, creationDate: Date = .init()) {
            self.id = id
            self.category = category
            self.title = title
            self.sets = sets
            self.reps = reps
            self.totalAmount = totalAmount
            self.minutes = minutes
            self.creationDate = creationDate
        }
    }
