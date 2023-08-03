//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts

struct CaloriesView: View {
    @State private var proteinAmount: Int = 3
    @State private var carbsAmount: Int = 5
    @State private var fatAmount: Int = 6
    @State private var sugarAmount: Int = 5
    @State private var caloriesAmount: Int = 0

    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    struct ChartData: Identifiable, Equatable {
        var id: String { return type }
        
        let type: String
        let count: Int
    }

    var body: some View {
        
        let data = [ChartData(type:"Protein", count: proteinAmount),
                        ChartData(type:"Carbs", count: carbsAmount),
                        ChartData(type:"Fat", count: fatAmount),
                        ChartData(type:"Sugar", count: sugarAmount)]
        
        NavigationStack {
            Form {
                LabeledContent {
                    TextField("", value: $caloriesAmount, formatter: Self.formatter)
                } label: {
                  Text("Calories")
                }
                Section {
                    LabeledContent {
                        TextField("", value: $proteinAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        Text("grams")
                    } label: {
                      Text("Protein")
                    }
                 
                    
                    LabeledContent {
                        TextField("", value: $carbsAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        Text("grams")
                    } label: {
                      Text("Carbs")
                    }
                    
                    LabeledContent {
                        TextField("", value: $fatAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        Text("grams")
                    } label: {
                      Text("Fat")
                    }
                    
                    LabeledContent {
                        TextField("", value: $sugarAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        Text("grams")
                    } label: {
                      Text("Sugar")
                    }
            }
                
                Chart(data) { dataPoint in
                    
                    BarMark(x: .value("Population", dataPoint.count),
                            y: .value("Type", dataPoint.type))
                    
                    .foregroundStyle(by: .value("Type", dataPoint.type))
                    .annotation(position: .overlay) {
                        Text("\(dataPoint.count)/200 grams")
                            .foregroundColor(.white)
                    }
                }
                .chartLegend(.hidden)
                .chartXAxis(.hidden)

                .aspectRatio(1, contentMode: .fit)
                .padding()
                  }
                  .navigationTitle("Calories Tracker")
                  .toolbarBackground(.orange, for: .navigationBar)
                  .toolbarBackground(.visible, for: .navigationBar)
              }
            
    }
}
   

struct CaloriesView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView()
    }
}
