//
//  OnboardingThirdPage.swift
//  Dawn
//
//  Created by Elias on 21/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct OnboardingThirdPageView: View {
    var nextAction: () -> Void

    @ObservedObject var vm = OnboardingViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Binding var firstName: String
    @Binding var age: Int
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var sex: String
    @Binding var activityLevel: String
    @Binding var calcPlans: Bool

    @State private var isSelected: Bool = false
    @State private var isSelected2: Bool = false
    @State private var isSelected3: Bool = false
    @State private var isSelected4: Bool = false
    @State private var isSelected5: Bool = false
    
    @State private var LoseWeightBuildMusclekcalGoal: Int = 0
    @State private var LoseWeightkcalGoal: Int = 0
    @State private var MaintenancekcalGoal: Int = 0
    @State private var GainWeightkcalGoal: Int = 0
    @State private var GainWeightBuildMusclekcalGoal: Int = 0
    
    @State private var LoseWeightBuildMusclepGoal: Int = 0
    @State private var LoseWeightpGoal: Int = 0
    @State private var MaintenancepGoal: Int = 0
    @State private var GainWeightpGoal: Int = 0
    @State private var GainWeightBuildMusclepGoal: Int = 0


    var body: some View {
        let kcalGoalLoseWeightBuildMuscle = vm.calculateLoseWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).kcalGoal
        
        let pGoalLoseWeightBuildMuscle = (vm.calculateLoseWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).proteinGoal.last! +
                                          vm.calculateLoseWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).proteinGoal.first!) / 2
        
        let kcalGoalLoseWeight = vm.calculateLoseWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: false).kcalGoal
        
        let kcalGoalMaintenance = vm.calculateMaintenance(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel)
        
        let kcalGoalGainWeight = vm.calculateGainWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: false).kcalGoal
        
        let kcalGoalGainWeightBuildMuscle = vm.calculateGainWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).kcalGoal
        
        let pGoalGainWeightBuildMuscle = (vm.calculateGainWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).proteinGoal.last! +
                                          vm.calculateGainWeight(age: age, weight: weight, height: height, sex: sex, activityLevel: activityLevel, workingOut: true).proteinGoal.first!) / 2
        
        VStack {
            Text("Hello, \(firstName)")
            ZStack(content: {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(isSelected ? .blue : .gray)
                VStack {
                    Text("Lose weight + build muscle")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                    
                    Text("kcal goal: \(LoseWeightBuildMusclekcalGoal)")
                        .foregroundStyle(.green)
                    
                    Text("protein goal: \(pGoalLoseWeightBuildMuscle)")
                        .foregroundStyle(.red)
                }
            })
            .onTapGesture {
                isSelected.toggle()
                if isSelected {
                    isSelected2 = false
                    isSelected3 = false
                    isSelected4 = false
                    isSelected5 = false
                }
            }
            .onAppear {
                LoseWeightBuildMusclekcalGoal = kcalGoalLoseWeightBuildMuscle
                LoseWeightBuildMusclepGoal = pGoalLoseWeightBuildMuscle
            }
            
            ZStack(content: {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(isSelected2 ? .blue : .gray)
                VStack {
                    Text("Lose weight")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                    Text("kcal goal: \(LoseWeightkcalGoal)")
                        .foregroundStyle(.green)
                }

            })
            .onTapGesture {
                isSelected2.toggle()
                if isSelected2 {
                    isSelected = false
                    isSelected3 = false
                    isSelected4 = false
                    isSelected5 = false
                }
            }
            .onAppear {
                LoseWeightkcalGoal = kcalGoalLoseWeight
                LoseWeightpGoal = 0
            }
            
            ZStack(content: {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(isSelected3 ? .blue : .gray)
                VStack {
                    Text("Maintenance")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        
                    Text("kcal goal: \(MaintenancekcalGoal)")
                        .foregroundStyle(.green)
                }
            })
            .task(id: calcPlans, {
                MaintenancekcalGoal = kcalGoalMaintenance
                MaintenancepGoal = 0
            })
            .onTapGesture {
                isSelected3.toggle()
                if isSelected3 {
                    isSelected2 = false
                    isSelected = false
                    isSelected4 = false
                    isSelected5 = false
                }
            }
            
            ZStack(content: {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(isSelected4 ? .blue : .gray)
                VStack {
                    Text("Gain weight")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        
                    Text("kcal goal: \(GainWeightkcalGoal)")
                        .foregroundStyle(.green)
                }
            })
            .onTapGesture {
                isSelected4.toggle()
                if isSelected4 {
                    isSelected2 = false
                    isSelected3 = false
                    isSelected = false
                    isSelected5 = false
                }
            }
            .onAppear {
                GainWeightkcalGoal = kcalGoalGainWeight
                GainWeightpGoal = 0
            }
            
            ZStack(content: {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(isSelected5 ? .blue : .gray)
                VStack {
                    Text("Gain weight + build muscle")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        
                    Text("kcal goal: \(GainWeightBuildMusclekcalGoal)")
                        .foregroundStyle(.green)

                    Text("protein goal: \(GainWeightBuildMusclepGoal)")
                        .foregroundStyle(.red)
                }
            })
            .onTapGesture {
                isSelected5.toggle()
                if isSelected5 {
                    isSelected2 = false
                    isSelected3 = false
                    isSelected4 = false
                    isSelected = false
                }
            }
            .onAppear {
                GainWeightBuildMusclekcalGoal = kcalGoalGainWeightBuildMuscle
                GainWeightBuildMusclepGoal = pGoalGainWeightBuildMuscle
            }

            Button(action: {
                if isSelected == true {
                    let settings = Settings(name: firstName, age: age, weight: weight, height: Int(height), sex: sex, kcalGoal: LoseWeightBuildMusclekcalGoal, pGoal: LoseWeightBuildMusclepGoal)
                    do {
                        context.insert(settings)
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if isSelected2 == true {
                    let settings = Settings(name: firstName, age: age, weight: weight, height: Int(height), sex: sex, kcalGoal: LoseWeightkcalGoal, pGoal: LoseWeightpGoal)
                    do {
                        context.insert(settings)
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if isSelected3 == true {
                    let settings = Settings(name: firstName, age: age, weight: weight, height: Int(height), sex: sex, kcalGoal: MaintenancekcalGoal, pGoal: MaintenancepGoal)
                    do {
                        context.insert(settings)
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if isSelected4 == true {
                    let settings = Settings(name: firstName, age: age, weight: weight, height: Int(height), sex: sex, kcalGoal: GainWeightkcalGoal, pGoal: GainWeightpGoal)
                    do {
                        context.insert(settings)
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                if isSelected5 == true {
                    let settings = Settings(name: firstName, age: age, weight: weight, height: Int(height), sex: sex, kcalGoal: GainWeightBuildMusclekcalGoal, pGoal: GainWeightBuildMusclepGoal)
                    do {
                        context.insert(settings)
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                nextAction()
               
            }, label: {
                Text("Set goals")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color.mint, in: .rect(cornerRadius: 10))
            }).padding(.top, 25)
        }.padding(40)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    OnboardingThirdPageView(firstName: .constant("Elias"), age: .constant(26), weight: .constant(70.0), height: .constant(180.0), sex: .constant("Male"), activityLevel: .constant("Normal"), kcalGoal: .constant(26), pGoal: .constant(26))
//}
