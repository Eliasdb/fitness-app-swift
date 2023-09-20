//
//  Photo.swift
//  Dawn
//
//  Created by Elias on 19/09/2023.
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI

@available(iOS 17.0, *)
@Model
class Photo: Hashable {
        var id: UUID
        var imageCategory: String
@Attribute(.externalStorage)
        var image: Data?
        var creationDate: Date 
        var dateAsString: String

    init(id: UUID = .init(), imageCategory: String, image: Data?, creationDate: Date = .init(),  dateAsString: String) {
            self.id = id
            self.imageCategory = imageCategory
            self.image = image
            self.creationDate = creationDate
            self.dateAsString = dateAsString
        }
    }
