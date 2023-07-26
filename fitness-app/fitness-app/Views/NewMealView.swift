//
//  NewMealView.swift
//  Dawn
//
//  Created by Elias on 26/07/2023.
//

import SwiftUI

struct NewMealView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var mealTitle: String = ""
    @State private var mealDate: Date = .init()
    @State private var mealColor: Color = .blue

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
                    
                    let colours: [Color] = [.blue, .green, .red]
                    
                    HStack(spacing: 0) {
                        ForEach(colours, id:\.self) { colour in
                            Circle()
                                .fill(colour)
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
            
            Button(action: {}, label: {
                Text("Create Entry")
                    .font(.title3)
                    .fontWeight(.semibold)
//                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(mealColor, in: .rect(cornerRadius: 10))
            })
            .disabled(mealTitle == "")
            .opacity(mealTitle == "" ? 0.5 : 1)
        })
        .padding(15)
    }
}

#Preview {
    NewMealView()
        .vSpacing(.bottom)
}
