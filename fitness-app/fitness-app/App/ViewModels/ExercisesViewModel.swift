//
//  ExercisesViewModel.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import Foundation

@available(iOS 17.0, *)
class ExercisesViewModel: ObservableObject {
    struct Data: Hashable {
        var  date: String
        var  dateasDate: Date
        var amount: Int
    }
    
    func exerciseChartData (exercises: [Exercise], category: String, exercise: String) -> [[Data]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var exercisesArray: [Data] = []
        
        let groupedExercisesbyDate = Dictionary(grouping: exercises.filter{$0.category.contains(category)}.filter{$0.title.contains(exercise)}, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedExercisesKeys =  groupedExercisesbyDate.map { $0.key }
        let groupedExercisesValues =  groupedExercisesbyDate.map { $0.value.map {$0.totalAmount}.reduce(0, +)}
        let sequence = zip(groupedExercisesKeys, groupedExercisesValues)
        
        for (el1, el2) in sequence {
            exercisesArray.append( Data(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }
        
        let sortedExercises = exercisesArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
        
        if sortedExercises.isEmpty {
            return [[]]
        }
        
        
        return sortedExercises
    }
    
    
    func getAverage (exercises: [Exercise], exercise: String, category: String) -> Int {
        let dateFormatter = DateFormatter()
        
        let groupedExercisesbyDate = Dictionary(grouping: exercises.filter{$0.title.contains(exercise)}.sorted( by: { $0.creationDate < $1.creationDate }), by: { dateFormatter.string(from: $0.creationDate) })
        
        let groupedExercisesValues = groupedExercisesbyDate.map {$0.value.map {$0.totalAmount}.reduce(0,+) }
        
        if (groupedExercisesValues.isEmpty) {
            return 0
        }
        let average = ((groupedExercisesValues.reduce(0, +) / (groupedExercisesValues.count)) )
        return average
    }
    
    func filterPhotos (photos: [Photo], selectedPhotoCategory: String) -> [Photo] {
        
        let photosArray = photos.filter{ $0.imageCategory.contains(selectedPhotoCategory) }
        return photosArray
    }
    
//    func exerciseProgressInt(exercisesPastWeek: [Exercise], category: String, exercise: String) -> Int {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .percent
//
//        let totalDeadliftRepsThisWeek: Int = exerciseChartData(exercises: exercisesPastWeek, category: category, exercise: exercise)[0].map { $0.amount }.reduce(0,+)
//        
//        return totalDeadliftRepsThisWeek
//        
//    }
}
