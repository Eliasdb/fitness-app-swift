//
//  OnboardingViewModel.swift
//  Dawn
//
//  Created by Elias on 21/09/2023.
//

import Foundation

@available(iOS 17.0, *)
class test: ObservableObject {
    struct LoseWeight {
        let kcalGoal: Int
        let proteinGoal: [Int]
    }
    
    struct GainWeight {
        let kcalGoal: Int
        let proteinGoal: [Int]
    }
    
    struct Payload  {
        let age: Int
        let weight: Double
        let height: Double
        let sex: String
        let activityLevel: String
        let workingOut: Bool
    }
    
    func someting(factor:Double, payload:Payload, gender: String) -> LoseWeight {
        if gender == "Male" {
            let weightMen = (13.397 * payload.weight)
            let heightMen = (4.799 * payload.height)
            let ageMen = (5.677 * Double(payload.age))
            let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2*payload.weight)), Int((2*payload.weight))]
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
            return finalKcal
        }
        
        if gender == "Female" {
            let weightWomen = (9.247 * payload.weight)
            let heightWomen = (3.098 * payload.height)
            let ageWomen = (4.330 * Double(payload.age))
            let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2*payload.weight)), Int((2*payload.weight))]
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
            return finalKcal
        }
       
        return LoseWeight(kcalGoal: 0, proteinGoal: [0])
    }
    
    func calculateLoseWeight(age: Int, weight: Double, height: Double, sex: String, activityLevel: String, workingOut: Bool ) -> LoseWeight {
        let weightMen = (13.397 * weight)
        let heightMen = (4.799 * height)
        let ageMen = (5.677 * Double(age))
        
        let weightWomen = (9.247 * weight)
        let heightWomen = (3.098 * height)
        let ageWomen = (4.330 * Double(age))
        let params = Payload(age:age, weight:weight, height:height, sex:sex,activityLevel:activityLevel, workingOut:workingOut)
        

//
//        if workingOut == false {
//            if sex == "Male" {
//                switch activityLevel {
//                case "No to a bit":
//                    let factor = 1.2
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Light":
//                    let factor = 1.375
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Normal":
//                    let factor = 1.55
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Heavy":
//                    let factor = 1.725
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Very heavy":
//                    let factor = 1.9
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    print(maintenanceKcal)
//                    print(tenPercentOfMaintenance)
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                default:
//                    let factor = 0.0
//                    let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                }
//            }
//
//            if sex == "Female" {
//                switch activityLevel {
//                case "No to a bit":
//                    let factor = 1.2
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Light":
//                    let factor = 1.375
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Normal":
//                    let factor = 1.55
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Heavy":
//                    let factor = 1.725
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                case "Very heavy":
//                    let factor = 1.9
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    print(maintenanceKcal)
//                    print(tenPercentOfMaintenance)
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                default:
//                    let factor = 0.0
//                    let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
//                    let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
//                    let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
//                    return finalKcal
//                }
//            }
//
//        }
        
        return LoseWeight(kcalGoal: 0, proteinGoal: [0])

    }
    
    func calculateGainWeight(age: Int, weight: Double, height: Double, sex: String, activityLevel: String, workingOut: Bool ) -> GainWeight {

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

    func calculateMaintenance(age: Int, weight: Double, height: Double, sex: String, activityLevel: String ) -> Int {
        let weightMen = (13.397 * weight)
        let heightMen = (4.799 * height)
        let ageMen = (5.677 * Double(age))
        
        if sex == "Male" {
            switch activityLevel {
            case "No to a bit":
                let factor = 1.2
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            case "Light":
                let factor = 1.375
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            case "Normal":
                let factor = 1.55
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            case "Heavy":
                let factor = 1.725
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            case "Very heavy":
                let factor = 1.9
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            default:
                let factor = 0.0
                let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
                return Int(maintenanceKcal)
            }
           
        }
        
        let weightWomen = (9.247 * weight)
        let heightWomen = (3.098 * height)
        let ageWomen = (4.330 * Double(age))
        
        if sex == "Female" {
            switch activityLevel {
            case "No to a bit":
                let factor = 1.2
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                return Int(maintenanceKcal)
            case "Light":
                let factor = 1.375
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
 
                return Int(maintenanceKcal)
            case "Normal":
                let factor = 1.55
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor

                return Int(maintenanceKcal)
            case "Heavy":
                let factor = 1.725
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                return Int(maintenanceKcal)
            case "Very heavy":
                let factor = 1.9
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                return Int(maintenanceKcal)
            default:
                let factor = 0.0
                let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
                return Int(maintenanceKcal)
            }

        }
   
  
        return 0
        
        


    }

}


