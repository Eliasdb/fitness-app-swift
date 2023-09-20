////
////  DawnTests.swift
////  DawnTests
////
////  Created by Elias on 20/09/2023.
////
//
import XCTest
@testable import Dawn


final class NutritionViewModelTests: XCTestCase {
    func testSuccessFullMacrosAverage() {
        // given (arrange)
        let vm = NutritionViewModel()

        let meals = [MealData(date: "20/09", dateasDate: Date(), amount: 5), MealData(date: "21/09", dateasDate: Date().advanced(by: 86400), amount: 15)]

        // when (act)
        
        let average = vm.getMacrosAverage(meals: meals)
        
        // then (assert)
        XCTAssertEqual(average, 10)
    }
}
