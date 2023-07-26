//
//  NewMealView.swift
//  Dawn
//
//  Created by Elias on 26/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct NewMealView: View {
    @Environment(\.dismiss) private var dismiss
    
    // model context to save data
    @Environment(\.modelContext) private var context
    @State private var mealTitle: String = ""
    @State private var mealDate: Date = .init()
    @State private var mealCalories: Double = 0
    @State private var count: Int = 0

    @State private var mealColor: String = "color 1"

    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
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
                          Slider(value: $mealCalories, in: 0...2000)
                          Text("\(Int(mealCalories))")
                      }
            })
            
            .padding(.top, 5)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Meal Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                   DatePicker("", selection: $mealDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                })
                .padding(.trailing, -15)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Meal Color")
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
                //                saving meal
                let meal = Meal(title: mealTitle, calories: Int(mealCalories), creationDate: mealDate, tint: mealColor)
                count += count + Int(mealCalories)

                do {
                    print("\(count)")
                    context.insert(meal)
                    try context.save()
                    dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }, label: {
                Text("Create Entry")
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
   NewMealView()
}
