//
//  NewMealView.swift
//  Dawn
//
//  Created by Elias on 26/07/2023.
//


import SwiftUI

@available(iOS 17.0, *)
struct AddMealView: View {
    @Environment(\.dismiss) private var dismiss
    // model context to save data
    @Environment(\.modelContext) private var context
    
    @State private var mealTitle: String = ""
    @State private var mealDate: Date = .init()
    @State private var mealColor: String = "Color 1"
    @Binding var mealCalories: Double
    @Binding var mealCarbs: Int
    @Binding var mealFat: Int
    @Binding var mealProtein: Int
    @Binding var currentDate: Date
    
    
    var body: some View {
        
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
                
                TextField("Chicken!", text: $mealTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
            })
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Calories")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                VStack {
                    Text("\(Int(mealCalories)) kcal")
                          Slider(value: $mealCalories, in: 0...2000)
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
                           Picker("protein", selection: $mealProtein){
                             
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
                              
                           Picker("carbs", selection: $mealCarbs){
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
                           
                           Picker("fat", selection: $mealFat){
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
                    
                   DatePicker("", selection: $mealDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                        .onAppear() {
                            mealDate = currentDate
                        }
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
                                        .opacity(mealColor == colour ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        mealColor = colour
                                    }
                                }
                        }
                    }
                })
            }
            .padding(.top, 5)
            
            Spacer(minLength: 0)
            
            Button(action: {
            // saving meal
                let meal = Meal(title: mealTitle, calories: Int(mealCalories), carbs: mealCarbs, fat: mealFat, protein: mealProtein, creationDate: mealDate, tint: mealColor)
                do {
                    context.insert(meal)
                    try context.save()
                    mealCalories = 0
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            
            }, label: {
                Text("Add Meal")
                    .font(.title3)
                    .fontWeight(.semibold)
//                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(Color(mealColor), in: .rect(cornerRadius: 10))
            })
            .disabled(mealTitle == "")
            .opacity(mealTitle == "" ? 0.5 : 1)
        })
        .padding(15)
    }
}

@available(iOS 17.0, *)
#Preview {
    HomeView()
        .modelContainer(for: [Meal.self], inMemory: true)

}
