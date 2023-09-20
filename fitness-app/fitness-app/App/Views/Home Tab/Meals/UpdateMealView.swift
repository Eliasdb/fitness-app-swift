//
//  UpdateMealView.swift
//  Dawn
//
//  Created by Elias on 09/09/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct UpdateMealView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var meal: Meal
    @State private var calendarId: Int = 0
    @State private var calories: Double = 0
    @State private var creationDate: Date = .init()
    @Binding var currentDate: Date
    
    struct IntDoubleBinding {
        let intValue : Binding<Int>
        
        let doubleValue : Binding<Double>
        
        init(_ intValue : Binding<Int>) {
            self.intValue = intValue
            
            self.doubleValue = Binding<Double>(get: {
                return Double(intValue.wrappedValue)
            }, set: {
                intValue.wrappedValue = Int($0)
            })
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 15, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .tint(.red)
                })
                .hSpacing(.leading)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Meal Title")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Chicken!", text: $meal.title)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                })
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Calories")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    VStack {
                        Text("\(Int(calories)) kcal")
                        Slider(value: $calories, in: 0...2000)
                    }
                })
                
                .padding(.top, 5)
                
                
                Section{
                    GeometryReader { geometry in
                        VStack(alignment: .leading, content: {
                            Text("Macros")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            HStack(alignment: .center, content: {
                                Picker("protein", selection: $meal.protein){
                                    
                                    ForEach(1..<150) { i in
                                        Text("\(i) grams protein")
                                            .font(.caption)
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 170, height: 40)
                                .clipped()
                                Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
                                    .resizable()
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 10, height:10)
                                    .position(x: -28, y: 19)
                                
                                Picker("carbs", selection: $meal.carbs){
                                    ForEach(1..<150) { i in
                                        Text("\(i) grams carbs")
                                            .font(.caption)
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 170, height:40)
                                .clipped()
                                Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
                                    .resizable()
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 10, height:10)
                                    .position(x: -28, y: 20)
                            })
                            .frame(height:40)
                            .cornerRadius(30)
                            
                            HStack(alignment: .center, content: {
                                
                                Picker("fat", selection: $meal.fat){
                                    ForEach(1..<150) { i in
                                        Text("\(i) grams fat")
                                            .font(.caption)
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                //                                   .padding(.top, 5)
                                
                                .frame(width: 170, height: 40)
                                .clipped()
                                Image(systemName: "arrowtriangle.left.fill.and.line.vertical.and.arrowtriangle.right.fill")
                                    .resizable()
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 10, height:10)
                                    .position(x: -28, y: 20)
                            })
                            .frame(height:40)
                        })
                    }
                    .frame(height:120)
                }
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Meal Date")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        DatePicker("Meal Date", selection: $creationDate).environment(\.locale, .current)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9, anchor: .leading)
                            .onAppear() {
                                creationDate = currentDate
                            }
                        //                        .id(calendarId)
                        //                        .onChange(of: creationDate, perform: { _ in
                        //                          calendarId += 1
                        //                        })
                        
                    })
                    .padding(.trailing, -15)
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Meal Color")
                        //                        .padding(.bottom, 15)
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        let colours: [String] = (1...3).compactMap { index -> String in
                            return "Color \(index)"
                        }
                        
                        HStack(spacing: 0) {
                            ForEach(colours, id:\.self) { colour in
                                Circle()
                                    .fill(Color(colour))
                                    .frame(width: 20, height: 20)
                                    .background(content: {
                                        Circle()
                                            .stroke(lineWidth: 2)
                                            .opacity(meal.tint == colour ? 1 : 0)
                                    })
                                    .hSpacing(.center)
                                    .padding(.top, 5)
                                    .padding(.bottom, 10)
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            meal.tint = colour
                                        }
                                    }
                            }
                        }
                    })
                }
                .padding(.top, 5)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    // updating meal
                    meal.calories = Int(calories)
                    meal.creationDate = creationDate
                    dismiss()
                    
                }, label: {
                    Text("Update Meal")
                        .font(.title3)
                        .fontWeight(.semibold)
                    //                    .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(Color(meal.tint), in: .rect(cornerRadius: 10))
                })
                .disabled(meal.title == "")
                .opacity(meal.title == "" ? 0.5 : 1)
            })
            .padding(15)
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

//
//#Preview {
//    UpdateMealView()
//}
