//
//  CalorieCounterView.swift
//  Dawn
//
//  Created by Elias on 02/08/2023.
//

import SwiftUI
import SwiftData
import Charts

@available(iOS 17.0, *)
struct CaloriesAndMacrosCounterView: View {
    @Binding var currentDate: Date
    @State var progressValue: Float = 0.0
    @Query private var meals: [Meal]
    @Query private var settings: [Settings]
    @State private var switchDonut: Bool = false
    
    init(currentDate: Binding<Date>) {
        self._currentDate = currentDate
        // predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Meal> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        // sorting
        let sortDescriptor = [
            SortDescriptor(\Meal.creationDate, order: .reverse)
        ]
        self._meals = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    
    var donutData: [(type: String, amount: Int)] {
        [(type: "Calories eaten", amount: meals.map {$0.calories}.reduce(0, +)),
         (type: "Calories not eaten yet", amount: (settings.last?.kcalGoal ?? 3000) - meals.map {$0.calories}.reduce(0, +))
          ]
    }
    
    var barChartData: [(type: String, amount: Int)] {
        [(type: "Protein", amount: meals.map {$0.protein}.reduce(0, +)),
         (type: "Carbs", amount: meals.map {$0.carbs}.reduce(0, +)),
         (type: "Fat", amount: meals.map {$0.fat}.reduce(0, +)),
          ]
    }
    
    var body: some View {
            VStack{
                Chart(donutData, id: \.type) { dataItem in
                    SectorMark(angle: .value("Type", dataItem.amount), innerRadius: .ratio(0.85), angularInset: 1.5)
                        .cornerRadius(5)
                        .foregroundStyle(by: .value("Name", dataItem.amount))
//                        .opacity(dataItem.type == "Calories eaten" ? 1 : 0.5 )
                }
                .frame(height:150)
                .chartLegend(.hidden)
                .chartBackground { chartProxy in
                  GeometryReader { geometry in
                      let frame = geometry[chartProxy.plotFrame!]
                    VStack {
                        if switchDonut == false {
                            Text("\(String(describing: max((settings.last?.kcalGoal ?? 3000) - meals.map {$0.calories}.reduce(0, +), 0))) kcal")
                                .foregroundColor(.white)
                                .font(.callout.bold())
                            Text("left")
                                .foregroundColor(.white)
                                .font(.callout.bold())
                        } else {
                            Text("\(String(describing: meals.map {$0.calories}.reduce(0, +))) kcal")
                                .foregroundColor(.white)
                                .font(.callout.bold())
                            Text("eaten")
                                .foregroundColor(.white)
                                .font(.callout.bold())
                        }

//                        Text("\(String(describing: " kcal")
                            
//                        .foregroundStyle(.secondary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                  }
                }
                .onTapGesture(perform: {
                    switchDonut.toggle()
                })
                .padding(50)
            
//                Chart(barChartData, id: \.type) { dataPoint in
//                
//                BarMark(x: .value("Type", dataPoint.type),
//                        y: .value("Population", dataPoint.amount), width: 40)
//                .foregroundStyle(by: .value("Type", dataPoint.type))
//                
//                .annotation(position: .overlay) {
//                    Text("\(dataPoint.amount)")
//                        .foregroundColor(.white)
//                }
//            }
//                .frame(width: 150, height: 150)
////              .chartLegend(.hidden)
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//                .foregroundColor(.white)
//                .aspectRatio(1, contentMode: .fit)
//                .padding()
            }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    HomeView()
//        .modelContainer(for: [Meal.self], inMemory: true)
//}

