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
    
    struct Payload  {
        let age: Int
        let weight: Double
        let height: Double
        let sex: String
        let activityLevel: String
        let workingOut: Bool
    }
    
    func dataTimesFactorWorkingOutL(factor:Double, payload:Payload, gender: String) -> LoseWeight {
        if gender == "Male" {
            let weightMen = (13.397 * payload.weight)
            let heightMen = (4.799 * payload.height)
            let ageMen = (5.677 * Double(payload.age))
            let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2 * payload.weight)), Int((2 * payload.weight))]
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
            return finalKcal
        }
        if gender == "Female" {
            let weightWomen = (9.247 * payload.weight)
            let heightWomen = (3.098 * payload.height)
            let ageWomen = (4.330 * Double(payload.age))
            let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2 * payload.weight)), Int((2 * payload.weight))]
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: proteinGoal)
            return finalKcal
        }
       
        return LoseWeight(kcalGoal: 0, proteinGoal: [0])
    }
    
    func dataTimesFactorNotWorkingOutL(factor:Double, payload:Payload, gender: String) -> LoseWeight {
        if gender == "Male" {
            let weightMen = (13.397 * payload.weight)
            let heightMen = (4.799 * payload.height)
            let ageMen = (5.677 * Double(payload.age))
            let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
            return finalKcal
        }
        if gender == "Female" {
            let weightWomen = (9.247 * payload.weight)
            let heightWomen = (3.098 * payload.height)
            let ageWomen = (4.330 * Double(payload.age))
            let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let finalKcal = LoseWeight(kcalGoal: Int(maintenanceKcal - tenPercentOfMaintenance), proteinGoal: [0])
            return finalKcal
        }
        return LoseWeight(kcalGoal: 0, proteinGoal: [0])
    }
    
    func dataTimesFactorNotWorkingOutG(factor:Double, payload:Payload, gender: String) -> GainWeight {
        if gender == "Male" {
            let weightMen = (13.397 * payload.weight)
            let heightMen = (4.799 * payload.height)
            let ageMen = (5.677 * Double(payload.age))
            let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
            return finalKcal
        }
        if gender == "Female" {
            let weightWomen = (9.247 * payload.weight)
            let heightWomen = (3.098 * payload.height)
            let ageWomen = (4.330 * Double(payload.age))
            let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: [0])
            return finalKcal
        }
        return GainWeight(kcalGoal: 0, proteinGoal: [0])
    }
    
    func dataTimesFactorWorkingOutG(factor:Double, payload:Payload, gender: String) -> GainWeight {
        if gender == "Male" {
            let weightMen = (13.397 * payload.weight)
            let heightMen = (4.799 * payload.height)
            let ageMen = (5.677 * Double(payload.age))
            let maintenanceKcal: Double = (88.362 + weightMen + heightMen - ageMen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2*payload.weight)), Int((2*payload.weight))]
            let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
            return finalKcal
        }
        if gender == "Female" {
            let weightWomen = (9.247 * payload.weight)
            let heightWomen = (3.098 * payload.height)
            let ageWomen = (4.330 * Double(payload.age))
            let maintenanceKcal: Double = (447.593 + weightWomen + heightWomen - ageWomen) * factor
            let tenPercentOfMaintenance: Double = maintenanceKcal * 0.1
            let proteinGoal: [Int] = [Int((1.2*payload.weight)), Int((2*payload.weight))]
            let finalKcal = GainWeight(kcalGoal: Int(maintenanceKcal + tenPercentOfMaintenance), proteinGoal: proteinGoal)
        }
        return GainWeight(kcalGoal: 0, proteinGoal: [0])
    }
    
    func calculateLoseWeight(age: Int, weight: Double, height: Double, sex: String, activityLevel: String, workingOut: Bool ) -> LoseWeight {
        let weightMen = (13.397 * weight)
        let heightMen = (4.799 * height)
        let ageMen = (5.677 * Double(age))
        
        let weightWomen = (9.247 * weight)
        let heightWomen = (3.098 * height)
        let ageWomen = (4.330 * Double(age))
        
        let params = Payload(age:age, weight:weight, height:height, sex:sex,activityLevel:activityLevel, workingOut:workingOut)

        if workingOut == true {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorWorkingOutL(factor: 1.2, payload: params, gender: "Male")
                case "Light":
                    return self.dataTimesFactorWorkingOutL(factor: 1.375, payload: params, gender: "Male")
                case "Normal":
                    return self.dataTimesFactorWorkingOutL(factor: 1.55, payload: params, gender: "Male")
                case "Heavy":
                    return self.dataTimesFactorWorkingOutL(factor: 1.725, payload: params, gender: "Male")
                case "Very heavy":
                    return self.dataTimesFactorWorkingOutL(factor: 1.9, payload: params, gender: "Male")
                default:
                    return self.dataTimesFactorWorkingOutL(factor: 0.0, payload: params, gender: "Male")
                }
            }
        
            if sex == "Female" {
               switch activityLevel {
               case "No to a bit":
                   return self.dataTimesFactorWorkingOutL(factor: 1.2, payload: params, gender: "Female" )
               case "Light":
                   return self.dataTimesFactorWorkingOutL(factor: 1.375, payload: params, gender: "Female" )
               case "Normal":
                   return self.dataTimesFactorWorkingOutL(factor: 1.55, payload: params, gender: "Female" )
               case "Heavy":
                   return self.dataTimesFactorWorkingOutL(factor: 1.725, payload: params, gender: "Female" )
               case "Very heavy":
                   return self.dataTimesFactorWorkingOutL(factor: 1.9, payload: params, gender: "Female" )
               default:
                   return self.dataTimesFactorWorkingOutL(factor: 0.0, payload: params, gender: "Female" )
               }
            }
            
            return LoseWeight(kcalGoal: 0, proteinGoal: [0])
        }
        
        if workingOut == false {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.2, payload: params, gender: "Male" )
                case "Light":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.375, payload: params, gender: "Male" )
                case "Normal":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.55, payload: params, gender: "Male" )
                case "Heavy":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.725, payload: params, gender: "Male" )
                case "Very heavy":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.9, payload: params, gender: "Male" )
                default:
                    return self.dataTimesFactorNotWorkingOutL(factor: 0.0, payload: params, gender: "Male" )
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.2, payload: params, gender: "Female" )
                case "Light":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.375, payload: params, gender: "Female" )
                case "Normal":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.55, payload: params, gender: "Female" )
                case "Heavy":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.725, payload: params, gender: "Female" )
                case "Very heavy":
                    return self.dataTimesFactorNotWorkingOutL(factor: 1.9, payload: params, gender: "Female" )
                default:
                    return self.dataTimesFactorNotWorkingOutL(factor: 0.0, payload: params, gender: "Female" )
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
        
        let params = Payload(age:age, weight:weight, height:height, sex:sex, activityLevel:activityLevel, workingOut:workingOut)
        
        if workingOut == false {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.2, payload: params, gender: "Male")
                case "Light":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.375, payload: params, gender: "Male")
                case "Normal":
                    let factor = 1.55
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.55, payload: params, gender: "Male")
                case "Heavy":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.725, payload: params, gender: "Male")
                case "Very heavy":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.9, payload: params, gender: "Male")
                default:
                    return self.dataTimesFactorNotWorkingOutG(factor: 0.0, payload: params, gender: "Male")
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.2, payload: params, gender: "Female")
                case "Light":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.375, payload: params, gender: "Female")
                case "Normal":
                    let factor = 1.55
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.55, payload: params, gender: "Female")
                case "Heavy":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.725, payload: params, gender: "Female")
                case "Very heavy":
                    return self.dataTimesFactorNotWorkingOutG(factor: 1.9, payload: params, gender: "Female")
                default:
                    return self.dataTimesFactorNotWorkingOutG(factor: 0.0, payload: params, gender: "Female")
                }
            }
        }
        
        if workingOut == true {
            if sex == "Male" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorWorkingOutG(factor: 1.2, payload: params, gender: "Male")
                case "Light":
                    return self.dataTimesFactorWorkingOutG(factor: 1.375, payload: params, gender: "Male")
                case "Normal":
                    return self.dataTimesFactorWorkingOutG(factor: 1.55, payload: params, gender: "Male")
                case "Heavy":
                    return self.dataTimesFactorWorkingOutG(factor: 1.725, payload: params, gender: "Male")
                case "Very heavy":
                    return self.dataTimesFactorWorkingOutG(factor: 1.9, payload: params, gender: "Male")
                default:
                    return self.dataTimesFactorWorkingOutG(factor: 0.0, payload: params, gender: "Male")
                }
            }
            
            if sex == "Female" {
                switch activityLevel {
                case "No to a bit":
                    return self.dataTimesFactorWorkingOutG(factor: 1.2, payload: params, gender: "Female")
                case "Light":
                    return self.dataTimesFactorWorkingOutG(factor: 1.375, payload: params, gender: "Female")
                case "Normal":
                    return self.dataTimesFactorWorkingOutG(factor: 1.55, payload: params, gender: "Female")
                case "Heavy":
                    return self.dataTimesFactorWorkingOutG(factor: 1.725, payload: params, gender: "Female")
                case "Very heavy":
                    return self.dataTimesFactorWorkingOutG(factor: 1.9, payload: params, gender: "Female")
                default:
                    return self.dataTimesFactorWorkingOutG(factor: 0.0, payload: params, gender: "Female")
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
