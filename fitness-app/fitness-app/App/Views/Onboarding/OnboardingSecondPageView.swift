//
//  OnboardingSecondPageView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI

struct OnboardingSecondPageView: View {
    var nextAction: () -> Void
    @Binding var firstName: String
    @Binding var age: Int
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var sex: String
    @Binding var activityLevel: String
    @Binding var calcPlans: Bool

    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var sexes: [String] = ["Male", "Female"]
    var levels: [String] = ["No to a bit", "Light", "Normal", "Heavy", "Very heavy"]
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Form {
                    Spacer().listRowSeparator(.hidden)
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text("Name")
                                .foregroundStyle(.gray)
                            
                            TextField("Name", text: $firstName)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 15)
                                .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                            
                        }).listRowSeparator(.hidden)
                        VStack(alignment: .leading, content: {
                            Text("Age")
                                .foregroundStyle(.gray)
                            TextField("Age", value: $age, formatter: formatter)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 15)
                                .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        })
                        .listRowSeparator(.hidden)
                        
                    }.listRowSeparator(.hidden)
                  
                    HStack {
                        VStack(alignment: .leading, content: {
                        Text("Weight")
                            .foregroundStyle(.gray)
                        TextField("Weight", value: $weight, formatter: formatter)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                            .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    }).listRowSeparator(.hidden)
                        
                    VStack(alignment: .leading, content: {
                        Text("Height")
        //                        .font(.caption)
                            .foregroundStyle(.gray)
                        TextField("Height", value: $height, formatter: formatter)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 15)
                            .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))

                    }).listRowSeparator(.hidden)}.listRowSeparator(.hidden)
               
                  
                    VStack(alignment: .leading, content: {
                        Text("Sex")
                            .foregroundStyle(.gray)
                                          
                        Picker("", selection: $sex){
                           ForEach(sexes, id: \.self) { i in
                               Text(i)
                                   .font(.caption)
                                   .tag(i)
                           }
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        }).listRowSeparator(.hidden)
                        
                        VStack(alignment: .leading, content: {
                            Text("Activity level")
                                .foregroundStyle(.gray)
                                          
                            Picker("", selection: $activityLevel){
                                ForEach(levels, id: \.self) { i in
                                    Text(i)
                                        .font(.caption)
                                        .tag(i)
                                       
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        }).listRowSeparator(.hidden)
                  
                    Button(action: {
                        nextAction()
                        calcPlans.toggle()
                    }, label: {
                        Text("Calculate goals")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .hSpacing(.center)
                            .padding(.vertical, 12)
                            .background(Color.mint, in: .rect(cornerRadius: 10))
                    }).padding(.top, 25)
                  
                }.scrollContentBackground(.hidden).background(.white).padding(40)
            }
        }
        .padding()
    }
}

//#Preview {
//    OnboardingSecondPageView()
//}
