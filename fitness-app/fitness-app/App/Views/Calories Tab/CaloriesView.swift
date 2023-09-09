//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI
import Foundation
import Collections

struct meal: Identifiable {
let id: UUID
let key: String
let value: Int
}
//
//extension Dictionary: Identifiable {
//    public typealias ID = Int
//    public var id: Int {
//        return hash
//    }
//}

@available(iOS 17.0, *)
struct CaloriesView: View {
    
    @State private var function: ()
        var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    Form {
                        CaloriesPastWeekView()
                    }
                }
                .navigationTitle("Calories")
                
                .toolbarBackground(.yellow, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)

                       
            }

     
        }
    }
    
    
@available(iOS 17.0, *)
struct CaloriesView_Previews: PreviewProvider {
        static var previews: some View {
            CaloriesView()
        }
    }

