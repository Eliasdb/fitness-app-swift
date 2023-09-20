//
//  Weight.swift
//  Dawn
//
//  Created by Elias on 18/09/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@Model
class Weight: Hashable {
        var id: UUID
        var weight: Double
        var creationDate: Date
                
    init(id: UUID = .init(), weight: Double, creationDate: Date = .init()) {
            self.id = id
            self.weight = weight
            self.creationDate = creationDate
        }
    }
