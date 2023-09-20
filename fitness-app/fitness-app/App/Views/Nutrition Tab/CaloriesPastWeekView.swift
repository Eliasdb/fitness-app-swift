//
//  CaloriesPastWeekView.swift
//  Dawn
//
//  Created by Elias on 08/09/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI



@available(iOS 17.0, *)
struct CaloriesPastWeekView: View {
    @ObservedObject var vm = ViewModel()
    @Query private var mealsPastWeek: [Meal]
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    @Binding var weekIndexCalories: Int

    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 4, content: {
                            HStack(content: {
                                Button(action: {
                                    weekIndexCalories+=1
                                    
                                    if weekIndexCalories >= vm.mealChartData(meals: mealsPastWeek).count {
                                        weekIndexCalories = 0
                                    }
                                }, label: {
                                    Image(systemName: "chevron.left")
                                }).buttonStyle(BorderlessButtonStyle())
                                Spacer()
                                if vm.mealChartData(meals: mealsPastWeek).isEmpty {
                                    Text("No data yet.")
                                        .font(.footnote)
                                        .foregroundStyle(.green)
                                        .fontWeight(.bold)
                                } else {
                                    Text("\(String(describing: vm.mealChartData(meals: mealsPastWeek)[weekIndexCalories].last!.date)) - \(String(describing: vm.mealChartData(meals: mealsPastWeek)[weekIndexCalories].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(.green)
                                        .fontWeight(.bold)
                                }
                              
                                Spacer()
                                Button(action: {
                                    weekIndexCalories-=1
                                    
                                    if weekIndexCalories == -1 {
                                        weekIndexCalories = 0
                                    }
                                    
                                }, label: {
                                    Image(systemName: "chevron.right")
                                }).buttonStyle(BorderlessButtonStyle())
                            })
                            .padding(.top, 20)
                            Spacer()
                            if vm.mealChartData(meals: mealsPastWeek).isEmpty {
                                Text("Eat something!")
                            } else {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text("Average")
                                 
                                    Text("\(vm.getAverage(meals: vm.mealChartData(meals:mealsPastWeek)[weekIndexCalories])) kcal")
                                            .fontWeight(.semibold)
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                            .padding(.bottom, 12)
                                    
                                })
                                    Chart {
                                        RuleMark(y: .value("Goal", 3000))
                                            .foregroundStyle(Color.mint)
                                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                                            .annotation(alignment: .trailing) {
                                                Text("Goal")
                                                    .font(.caption)
                                                    .foregroundStyle(.secondary)
                                            }
                                        ForEach((vm.mealChartData(meals: mealsPastWeek)[weekIndexCalories].sorted(by: { $0.dateasDate < ($1.dateasDate)})) , id: \.self) { item in
                                            BarMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                            .foregroundStyle(Color.accentColor.gradient)}
                                    }
                                    .frame(height: 180)
                                    .chartYAxis {
                                        AxisMarks(position: .leading)
                                    }
                            }
                        
                        }).padding(.horizontal, 15 ).padding(.bottom, 15)
                    }
                }
            } label: {
                CaloriesDetailView()
            }
        }
    }
}

//#Preview {
//    if #available(iOS 17.0, *) {
//        CaloriesPastWeekView()
//    } else {
//        // Fallback on earlier versions
//    }
//}
