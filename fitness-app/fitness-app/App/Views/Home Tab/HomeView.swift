//
//  HomeViewv2.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI
import _SwiftData_SwiftUI

@available(iOS 17.0, *)
struct HomeView: View {
    @State private var mealCalories: Double = 0
    @State private var mealFat: Int = 0
    @State private var mealProtein: Int = 0
    @State private var mealCarbs: Int = 0
    @State private var mealColor: String = "Color 1"
    @State private var currentDate: Date = .init()

    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @State private var createNewMeal: Bool = false
    @State private var createNewExercise: Bool = false
    @Binding var categories: [String : [(name: String, sets: Int, reps: Int)]]
    
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HeaderView()
            CaloriesAndMacrosCounterView(currentDate: $currentDate)
            HStack {
                ScrollView(.vertical) {
                    VStack {
                        MealsView(currentDate: $currentDate)
                      
                    }
                    .hSpacing(.center)
                    .vSpacing(.center)
                }
                .scrollIndicators(.hidden)
                ScrollView(.vertical) {
                    VStack {
                        AllExercisesView(currentDate: $currentDate, categories: $categories)
                    }
                    .hSpacing(.center)
                    .vSpacing(.center)
                }
                .scrollIndicators(.hidden)
            }
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            VStack {
                Button(action: {
                    createNewMeal.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 55, height: 55)
                        .background(.blue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10 )), in: .circle)
                })
//                .padding(15)
                .padding(.bottom, 5)
                Button(action: {
                    createNewExercise.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 55, height: 55)
                        .background(.green.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10 )), in: .circle)
                })
                .padding(15)
                
            }
         
        })
        .background(.mint)
        .onAppear(perform: {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        })
        .sheet(isPresented: $createNewMeal, content: {
            AddMealView(mealCalories: $mealCalories,  mealCarbs: $mealCarbs, mealFat: $mealFat, mealProtein: $mealProtein, currentDate: $currentDate)
                .presentationDetents([.height(520)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.white)
        })
        .sheet(isPresented: $createNewExercise, content: {
            AddExerciseView(currentDate: $currentDate, categories: $categories)
                .presentationDetents([.height(520)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.teal)
        })
    }
       
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.blue)
                
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            
            // week slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 95)
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing, content: {
            Button(action: {}, label: {
                Image("profilepic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            })
        })
        .padding(15)
        .background(.white)
        .onChange(of: currentWeekIndex) { newValue in
                if newValue == 0 || newValue == (weekSlider.count - 1) {
                    createWeek = true
                }
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background(content: {
                            if isSameDate(day.date, currentDate) {
                                Rectangle()
                                    .fill(.blue)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday {
                                Rectangle()
                                    .fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .rect)

                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        // when offset reaches 15 and if createweek is toggled then generate next set of week
                        if value.rounded() == 15 && createWeek {
                            print("Generate")
                            paginateWeek()
                            createWeek = false
                        }
                    }
            }
        }
    }

    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                // inserting new week at 0th index and removing last array item
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                // appending new week at last index and removing first array item
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
}


//@available(iOS 17.0, *)
//#Preview {
//         HomeView(currentDate: $currentDate)
//            .modelContainer(for: [Meal.self], inMemory: true)
//}
