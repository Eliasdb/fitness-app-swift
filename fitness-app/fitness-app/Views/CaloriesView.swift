//
//  CaloriesView.swift
//  FitnessApp
//
//  Created by Elias on 19/07/2023.
//

import SwiftUI
import Charts

struct CaloriesView: View {
    @State private var proteinAmount = 3
    @State private var carbsAmount = 5
    @State private var fatAmount = 6
    @State private var sugarAmount = 5
    
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
                Section {
                        TextField("Protein", value: $proteinAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        TextField("Carbs", value: $carbsAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        TextField("Fat", value: $fatAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
                        TextField("Sugar", value: $sugarAmount, formatter: Self.formatter)
                            .keyboardType(.numberPad)
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
