//
//  OnboardingViewModel.swift
//  Dawn
//
//  Created by Elias on 21/09/2023.
//

import Foundation

@available(iOS 17.0, *)
class OnboardingViewModel: ObservableObject {
    struct LoseWeight {
        let kcalGoal: Int
        let proteinGoal: [Int]
    }
    
    struct GainWeight {
        let kcalGoal: Int
        let proteinGoal: [Int]
    }
    
    func calculateLoseWeight(age: Int, weight: Double, height: Double, sex: String, activityLevel: String, workingOut: Bool ) -> LoseWeight {
//        Losing weight = maintenance - 10%
//        Men  -> 88,362 + (13,397 x gewicht) + (4,799 x lichaamslengte in cm) – (5,677 x leeftijd in jaren)
//        Women -> 447,593 + (9,247 x gewicht) + (3,098 x lichaamslengte in cm) – (4,330 x leeftijd in jaren)

        let weightMen = (13.397 * weight)
        let heightMen = (4.799 * height)
        let ageMen = (5.677 * Double(age))
        
        let weightWomen = (9.247 * weight)
        let heightWomen = (3.098 * height)
        let ageWomen = (4.330 * Double(age))
        if workingOut == true {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]

                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                }
            }
            return LoseWeight(kcalGoal: 0, proteinGoal: [0])
        }
        
        if workingOut == false {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                }
            }
            
        }
        return LoseWeight(kcalGoal: 0, proteinGoal: [0])

    }
    
    func calculateGainWeight(age: Int, weight: Double, height: Double, sex: String, activityLevel: String, workingOut: Bool ) -> GainWeight {
//        Losing weight = maintenance + 10%
//        Men  -> 88,362 + (13,397 x gewicht) + (4,799 x lichaamslengte in cm) – (5,677 x leeftijd in jaren)
//        Women -> 447,593 + (9,247 x gewicht) + (3,098 x lichaamslengte in cm) – (4,330 x leeftijd in jaren)

        let weightMen = (13.397 * weight)
        let heightMen = (4.799 * height)
        let ageMen = (5.677 * Double(age))
        
        let weightWomen = (9.247 * weight)
        let heightWomen = (3.098 * height)
        let ageWomen = (4.330 * Double(age))
        
        if workingOut == false {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
                    return finalKcal
                }
            }
        }
        
        if workingOut == true {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    let factor = 1.2
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Light":
                    let factor = 1.375
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Normal":
                    let factor = 1.55
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Heavy":
                    let factor = 1.725
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                case "Very heavy":
                    let factor = 1.9
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    print(maintenanceKcal)
                    print(tenPercentOfMaintenance)
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                default:
                    let factor = 0.0
                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
                    let proteinGoal: [Int] = [Int((1.2*weight)), Int((2*weight))]
                    let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
                    return finalKcal
                }
            }
        }
    
        return GainWeight(kcalGoal: 0, proteinGoal: [0])
    }


}


