//
//  MacrosPastWeekView.swift
//  Dawn
//
//  Created by Elias on 13/09/2023.
//

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
struct MacrosPastWeekView: View {
    @ObservedObject var vm = ViewModel()
    @Query private var mealsPastWeek: [Meal]
    @Binding var weekIndexMacros: Int
    @State private var today: Date = .init()
    @State private var weekIndex: Int = 0
    @State private var macro: String = ""
    
    var macros = ["Carbs", "Fat", "Protein"]

    var body: some View {
        Section {
            NavigationLink {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 4, content: {
                            HStack(content: {
                                Button(action: {
                                    weekIndexMacros+=1
                                    
                                    if weekIndexMacros >= vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).count {
                                        weekIndexMacros = 0
                                    }
                                }, label: {
                                    switch macro {
                                    case "Protein": Image(systemName: "chevron.left").foregroundStyle(.indigo)
                                    case "Carbs": Image(systemName: "chevron.left").foregroundStyle(.yellow)
                                    case "Fat": Image(systemName: "chevron.left").foregroundStyle(.red)
                                    default:
                                        Image(systemName: "chevron.left").foregroundStyle(.green)
                                    }
                              
                                }).buttonStyle(BorderlessButtonStyle())
                                Spacer()
                              
                                
                                if vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).isEmpty {
                                    Text("No data yet")
                                        .font(.footnote)
                                        .foregroundStyle(.green)
                                        .fontWeight(.bold)
                                } else if !vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].isEmpty {
                                    
                                switch macro {
                                case "Protein":
                                    Text("\(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].last!.date)) - \(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(.indigo)
                                        .fontWeight(.bold)
                                case "Fat":
                                    Text("\(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].last!.date)) - \(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                case "Carbs":
                                    Text("\(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].last!.date)) - \(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(.yellow)
                                        .fontWeight(.bold)
                                default:
                                    Text("\(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].last!.date)) - \(String(describing: vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].first!.date))")
                                        .font(.footnote)
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                }
                               
                                }
                                Spacer()
                                Button(action: {
                                    weekIndexMacros-=1
                                    
                                    if weekIndexMacros == -1 {
                                        weekIndexMacros = 0
                                    }
                                    
                                }, label: {
                                    switch macro {
                                    case "Protein": Image(systemName: "chevron.right").foregroundStyle(.indigo)
                                    case "Carbs": Image(systemName: "chevron.right").foregroundStyle(.yellow)
                                    case "Fat": Image(systemName: "chevron.right").foregroundStyle(.red)
                                    default:
                                        Image(systemName: "chevron.right").foregroundStyle(.green)
                                    }
                                }).buttonStyle(BorderlessButtonStyle())
                            })
                            .padding(.top, 20)
                            Spacer()
                            if vm.mealDonutChartData(meals: mealsPastWeek, macro: macro).isEmpty {
                                Text("Eat something!")
                            } else {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    switch macro {
                                    case "Protein": Text("Average").foregroundStyle(.indigo)
                                    case "Carbs": Text("Average").foregroundStyle(.yellow)
                                    case "Fat": Text("Average").foregroundStyle(.red)
                                    default:
                                        Text("Average").foregroundStyle(.green)
                                    }
                                    Text("\(vm.getMacrosAverage(meals: vm.mealDonutChartData(meals:mealsPastWeek, macro: macro)[weekIndexMacros])) grams")
                                            .fontWeight(.semibold)
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                            .padding(.bottom, 12)
                                })
                                
                                Chart {
                                    switch macro {
                                    case "Carbs":
                                        ForEach(vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                            AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                .foregroundStyle(Color.yellow.gradient)
                                        }
                                    case "Protein":
                                        ForEach(vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                            AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                .foregroundStyle(Color.indigo.gradient)
                                        }
                                    case "Fat":
                                        ForEach(vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                            AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                .foregroundStyle(Color.red.gradient)
                                        }
                                    default:
                                        ForEach(vm.mealDonutChartData(meals: mealsPastWeek, macro: macro)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                            AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                .foregroundStyle(Color.red.gradient)
                                        }
                                    }
                                }
                                .frame(height: 180)
                                .chartYAxis {
                                    AxisMarks(position: .leading)
                                }
                                Picker("", selection: $macro) {
                                    ForEach(macros, id: \.self) { item in
                                        Text("\(item)")
                                            .tag(item)
                                    }
                                }.onAppear() {
                                    macro = "Fat"
                                }
                            }
                            
                        }).padding(.horizontal, 15 ).padding(.bottom, 15)

                    }
                }
            } label: {
                MacrosDetailView()
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
