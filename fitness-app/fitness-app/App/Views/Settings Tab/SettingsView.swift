//
//  SettingsView.swift
//  fitness-app
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct SettingsView: View {
    @Query var settings: [Settings]
    @Environment(\.modelContext) private var context

    @State var fname: String = ""
    @State var age: Int = 0
    @State var weight: Double = 0.0
    @State var height: Int = 0
    @State var sex: String = ""
    @State var kcalGoal: Int = 0
    @State var pGoal: Int = 0

    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var sexes = ["Male", "Female"]
    
    var body: some View {
        printv("settings: \(settings.count)")
        NavigationStack {
            List {
                Section {
                    LabeledContent {
                        TextField("lkjhjgvhkj", text: $fname)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                if settings.isEmpty {
                                    fname = ""
                                } else {
                                    fname = settings.last!.name
                                }
                              
                            })
                          
                    } label: {
                        Text("Your name")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", value: $age, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                age = settings.last!.age
                            })
                    } label: {
                        Text("Your age")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", value: $weight, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                weight = settings.last!.weight
                            })
                    } label: {
                        Text("Your weight (kg)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", value: $height, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                height = settings.last!.height
                            })
                    } label: {
                        Text("Your height (cm)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        
                        Picker("", selection: $sex){
                            ForEach(sexes, id: \.self) { i in
                                Text(i)
                                    .font(.caption)
                                    .tag(i)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .onAppear(perform: {
                            sex = settings.last!.sex
                        })
                           
                    } label: {
                        Text("Your sex")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                } header: {
                    Text("Biometrics")
                }
                
                Section {
                    LabeledContent {
                        TextField("kcal goal", value: $kcalGoal, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                if settings.isEmpty {
                                    kcalGoal = 0
                                } else {
                                    kcalGoal = settings.last!.kcalGoal
                                }
                            })
                          
                    } label: {
                        Text("Kcal goal")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", value: $pGoal, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                pGoal = settings.last!.pGoal
                            })
                    } label: {
                        Text("Protein goal")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    
                } header: {
                    Text("Goals")
                }
        
        
                Button(action: {
                    settings.last!.name = fname
                    settings.last!.age = age
                    settings.last!.weight = weight
                    settings.last!.height = height
                    settings.last!.sex = sex
                    settings.last!.pGoal = pGoal
                    settings.last!.kcalGoal = kcalGoal
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }, label: {
                    Text("Edit profile")
                })
            }
//                LabeledContent {
//                    TextField("60kg", value: $weight, format: .number)
//                        .listRowSeparator(.hidden)
//                } label: {
//                    Text("Your weight")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                }
//                header : {
//
//                }
           

            .navigationTitle("Settings")
            .toolbarBackground(.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


//@available(iOS 17.0, *)
//#Preview {
//   SettingsView()
//}

