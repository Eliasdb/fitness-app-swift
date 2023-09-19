//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts
import _SwiftData_SwiftUI
import Foundation
import Collections
import PhotosUI


@available(iOS 17.0, *)
struct NutritionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var calendarId: Int = 0

    @Query private var mealsPastWeek: [Meal]

    @Query private var weights: [Weight]
    @State private var today: Date = .init()
    @State private var weekIndexCalories: Int = 0
    @State private var weekIndexMacros: Int = 0
    @State private var weight: Double = 0.0
    @State private var macro: String = ""

    @State private var weightDay: Date = Date()
    @State private var currentDateString: String = ""

 
    var macros = ["Carbs", "Fat", "Protein"]


    init() {
        self.today = today
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: today)
        let todayminus30 = calendar.date(byAdding: .day, value: -365, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate < today && $0.creationDate > todayminus30
        }
//         sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .reverse)
        ]
        
        self._mealsPastWeek = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    struct Datar: Hashable {
        var type: Int
        var amount: Int
    }
    
    struct MealData: Hashable {
        var  date: String
        var  dateasDate: Date
        var amount: Int
    }
    
    struct WeightData: Hashable {
        var date: String
        var dateasDate: Date
        var amount: Double
    }
    
    
    var x: [Datar] = [Datar(type: 1, amount:60), Datar(type: 2, amount:80), Datar(type: 3, amount:100), Datar(type: 4, amount:40), Datar(type:5, amount:20), Datar(type:6, amount:50), Datar(type:7, amount:70)]

    func mealChartData (meals: [Meal]) -> [[MealData]]  {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var mealsArray: [MealData] = []
        
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }
        let groupedMealsValues =  groupedMeals.map { $0.value.map { Int($0.calories) }.reduce(0, +)}
        let sequence = zip(groupedMealsKeys, groupedMealsValues)
        
        for (el1, el2) in sequence {
            mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
        }
        
        let sortedMeals = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
        
        return sortedMeals
        }
    
    func getAverage (meals: [MealData]) -> Int {
        let allCalories = meals.map {$0.amount}.reduce(0, +)
        let numberOfMeals = meals.count
        
        let average = allCalories / numberOfMeals
        
        if (meals.isEmpty) {
            return 0
        }
        return average
    }
    
    func getDateString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func mealDonutChartData (meals: [Meal]) ->  [[MealData]]   {
        //formats date of meal
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        var mealsArray: [MealData] = []
        let groupedMeals = Dictionary(grouping: meals, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedMealsKeys =  groupedMeals.map { $0.key }

        if macro == "Protein" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.protein }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Carbs" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.carbs }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro
        }
        
        if macro == "Fat" {
            let groupedMealsValues =  groupedMeals.map { $0.value.map { $0.fat }.reduce(0, +)}
            let sequence = zip(groupedMealsKeys, groupedMealsValues)
            
            for (el1, el2) in sequence {
                mealsArray.append( MealData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2))
            }
            
            let sortedMacro = mealsArray.sorted(by: { $0.dateasDate > ($1.dateasDate)}).chunked(into: 7)
            return sortedMacro

        }
        
        if (meals.isEmpty) {
            return [[]]
        }
        
        return [[]]
    }
    
    func getMacrosAverage (meals: [MealData]) -> Int {
        let allCalories = meals.map {$0.amount}.reduce(0, +)
        let numberOfMeals = meals.count
        
        
        if (meals.isEmpty) {
            return 0
        }
        
        let average = allCalories / numberOfMeals

        return average
    }
    
  
    
    func getWeights () -> [WeightData] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        var weightsArray: [WeightData] = []

        
        let groupedWeights = Dictionary(grouping: weights, by: { dateFormatter.string(from: $0.creationDate) })
        let groupedWeightsKeys =  groupedWeights.map { $0.key }
        let groupedWeightsValues =  groupedWeights.map { $0.value.map { $0.weight }.last}
//        print(groupedWeightsValues)
        let sequence = zip(groupedWeightsKeys, groupedWeightsValues)
        for (el1, el2) in sequence {
            weightsArray.append( WeightData(date: el1, dateasDate: Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: el1)!)!, amount: el2!))
        }
        let sortedWeights = weightsArray.sorted(by: { $0.dateasDate < ($1.dateasDate)})
        return sortedWeights
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        List {
                            Section {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    HStack(content: {
                                        Button(action: {
                                            weekIndexCalories+=1
                                            
                                            if weekIndexCalories >= mealChartData(meals: mealsPastWeek).count {
                                                weekIndexCalories = 0
                                            }
                                        }, label: {
                                            Image(systemName: "chevron.left")
                                        }).buttonStyle(BorderlessButtonStyle())
                                        Spacer()
                                        if mealChartData(meals: mealsPastWeek).isEmpty {
                                            Text("No data yet.")
                                                .font(.footnote)
                                                .foregroundStyle(.green)
                                                .fontWeight(.bold)
                                        } else {
                                            Text("\(String(describing: mealChartData(meals: mealsPastWeek)[weekIndexCalories].last!.date)) - \(String(describing: mealChartData(meals: mealsPastWeek)[weekIndexCalories].first!.date))")
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
                                    if mealChartData(meals: mealsPastWeek).isEmpty {
                                        Text("Eat something!")
                                    } else {
                                        VStack(alignment: .leading, spacing: 4, content: {
                                            Text("Average")
                                         
                                                Text("\(getAverage(meals: mealChartData(meals:mealsPastWeek)[weekIndexCalories])) kcal")
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
                                                ForEach((mealChartData(meals: mealsPastWeek)[weekIndexCalories].sorted(by: { $0.dateasDate < ($1.dateasDate)})) , id: \.self) { item in
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
                
                Section {
                    NavigationLink {
                        List {
                            Section {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    HStack(content: {
                                        Button(action: {
                                            weekIndexMacros+=1
                                            
                                            if weekIndexMacros >= mealDonutChartData(meals: mealsPastWeek).count {
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
                                      
                                        
                                        if mealDonutChartData(meals: mealsPastWeek).isEmpty {
                                            Text("No data yet")
                                                .font(.footnote)
                                                .foregroundStyle(.green)
                                                .fontWeight(.bold)
                                        } else if !mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].isEmpty {
                                            
                                        switch macro {
                                        case "Protein":
                                            Text("\(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].last!.date)) - \(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].first!.date))")
                                                .font(.footnote)
                                                .foregroundStyle(.indigo)
                                                .fontWeight(.bold)
                                        case "Fat":
                                            Text("\(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].last!.date)) - \(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].first!.date))")
                                                .font(.footnote)
                                                .foregroundStyle(.red)
                                                .fontWeight(.bold)
                                        case "Carbs":
                                            Text("\(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].last!.date)) - \(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].first!.date))")
                                                .font(.footnote)
                                                .foregroundStyle(.yellow)
                                                .fontWeight(.bold)
                                        default:
                                            Text("\(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].last!.date)) - \(String(describing: mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].first!.date))")
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
                                    if mealDonutChartData(meals: mealsPastWeek).isEmpty {
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
                                                Text("\(getMacrosAverage(meals: mealDonutChartData(meals:mealsPastWeek)[weekIndexMacros])) grams")
                                                    .fontWeight(.semibold)
                                                    .font(.footnote)
                                                    .foregroundStyle(.secondary)
                                                    .padding(.bottom, 12)
                                        })
                                        
                                        Chart {
                                            switch macro {
                                            case "Carbs":
                                                ForEach(mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                                    AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                        .foregroundStyle(Color.yellow.gradient)
                                                }
                                            case "Protein":
                                                ForEach(mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                                    AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                        .foregroundStyle(Color.indigo.gradient)
                                                }
                                            case "Fat":
                                                ForEach(mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                                    AreaMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                        .foregroundStyle(Color.red.gradient)
                                                }
                                            default:
                                                ForEach(mealDonutChartData(meals: mealsPastWeek)[weekIndexMacros].sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
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
                
                Section {
                    NavigationLink {
                        VStack {
                            Form {
                                Section {
                                    
                                    if getWeights().isEmpty {
                                        Text("No data yet...")
                                    } else {
                                        Chart {
                                            ForEach(getWeights().sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                                LineMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                                    .foregroundStyle(Color("TestColor").gradient)
                                            }
                                        }
                                        .chartScrollableAxes(.horizontal)
//                                        .chartXVisibleDomain(length: -2)
                                        .chartScrollPosition(initialX: getDateString(date: weightDay))
                                        .chartScrollTargetBehavior(
                                            .valueAligned(matching: .init(hour:0), majorAlignment: .matching(.init(day:1)))
                                        )
                                      
                                        .frame(height: 180)
                                        .padding(15)
                                        .chartYAxis {
                                            AxisMarks(position: .leading)
                                        }
                                    }
                                }

                                Section {
                                    LabeledContent {
                                        TextField("60kg", value: $weight, format: .number)
                                    } label: {
                                        Text("Your weight")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    
                                    ZStack {
                                        Spacer()
                                        HStack {
                                            LabeledContent {
                                                DatePicker("", selection: $weightDay)
                                                    .datePickerStyle(.compact)
                                                    .labelsHidden()
                                                    .scaleEffect(0.9, anchor: .center)
                                            } label: {
                                                Text("Date")
                                                    .font(.caption)
                                                    .foregroundStyle(.gray)
                                            }
                                        }                                            
                                        Spacer()

                                    }
                                  
                                    Button(action: {
                                        // saving meal
                                        let weight = Weight(weight: weight,creationDate: weightDay)
                                        do {
                                            context.insert(weight)
                                            try context.save()
                                            
                                        } catch {
                                            print(error.localizedDescription)
                                        }
                                        
                                    }, label: {
                                        Text("Add current weight")
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                        //                    .textScale(.secondary)
                                            .foregroundStyle(.black)
                                            .hSpacing(.center)
                                            .padding(.vertical, 12)
                                            .background(Color(.green), in: .rect(cornerRadius: 10))
                                    })
                                }
                            }
                        }
                        Spacer()
                    } label : {
                        WeightTrackerDetailView()
                    }
                }
                
                
            }.navigationTitle("Nutrition")
                .toolbarBackground(.mint, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//
//@available(iOS 17.0, *)
//#Preview {
//        NutritionView()
//}

