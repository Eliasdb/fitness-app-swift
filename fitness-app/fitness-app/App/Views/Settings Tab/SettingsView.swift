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
    
    @State var fname: String = ""
    @State var age: Int = 0
    @State var weight: Double = 0.0
    @State var height: Int = 0
    @State var sex: String = ""
    
    let formatter: NumberFormatter = {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           return formatter
       }()
    
    var body: some View {
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
                                    fname = settings.first!.name
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
                                age = settings.first!.age
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
                                weight = settings.first!.weight
                            })
                    } label: {
                        Text("Your weight")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", value: $height, formatter: formatter)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                height = settings.first!.height
                            })
                    } label: {
                        Text("Your height")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    LabeledContent {
                        TextField("lkjhjgvhkj", text: $sex)
                            .listRowSeparator(.hidden)
                            .onAppear(perform: {
                                sex = settings.first!.sex
                            })
                    } label: {
                        Text("Your sex")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                } header: {
                    Text("Biometrics")
                }
        
                
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

