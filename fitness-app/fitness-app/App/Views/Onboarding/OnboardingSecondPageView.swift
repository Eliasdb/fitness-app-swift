//
//  OnboardingSecondPageView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI

struct OnboardingSecondPageView: View {
    var nextAction: () -> Void
    @State private var firstName: String = ""
    @State private var age: Int = 0
    @State private var weight: Double = 0.0
    @State private var height: Double = 0.0
    @State private var sex: String = ""
    @State private var activityLevel: String = ""

    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var sexes: [String] = ["Male", "Female"]
    var levels: [String] = ["No to a bit", "Light", "Normal", "Heavy exercise", "Very heavy"]
    var body: some View {
        VStack(spacing: 20) {
            Form {
                VStack(alignment: .leading, content: {
                    Text("Name")
    //                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Name", text: $firstName)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                })
                
                VStack(alignment: .leading, content: {
                    Text("Age")
    //                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Age", value: $age, formatter: formatter)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                })
        
                VStack(alignment: .leading, content: {
                    Text("Weight")
    //                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Weight", value: $weight, formatter: formatter)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                })
                
                VStack(alignment: .leading, content: {
                    Text("Height")
    //                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Height", value: $height, formatter: formatter)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))

                })

                VStack(alignment: .leading, content: {
                    Text("Sex")
                    //                        .font(.caption)
                                       .foregroundStyle(.gray)
                                  
                                       Picker("", selection: $sex){
                                           ForEach(sexes, id: \.self) { i in
                                               Text(i)
                                                   .font(.caption)
                                                   .tag(i)
                                           }
                                       } .padding(.vertical, 12)
                        .padding(.horizontal, 10)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        
                })
                
                VStack(alignment: .leading, content: {
                    Text("Activity level")
    //                        .font(.caption)
                        .foregroundStyle(.gray)
                                  
                    Picker("", selection: $activityLevel){
                        ForEach(levels, id: \.self) { i in
                            Text(i)
                                .font(.caption)
                                .tag(i)
                               
                    }
                }.padding(.vertical, 12)
                                        .padding(.horizontal, 10)
                                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                       
                        
                })
        
            }.navigationTitle("Biometrics")
                .background(Color.white)

        }.padding().background(Color.white)

    }
}

//#Preview {
//    OnboardingSecondPageView()
//}
