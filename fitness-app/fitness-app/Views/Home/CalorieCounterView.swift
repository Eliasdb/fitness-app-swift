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
struct CalorieCounterView: View {
    @Binding var currentDate: Date
    
    @Query private var meals: [Meal]
    @Query private var calorieCounter: [Count]
    
    @State var progressValue: Float = 0.0

    
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
        self._currentDate = currentDate
        // predicate
        let predicate2 = #Predicate<Count> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }

        self._calorieCounter = Query(filter: predicate2, animation: .snappy)
    }
    
    var data: [(type: String, amount: Int)] {
        [(type: "Calories eaten", amount: meals.map {$0.calories}.reduce(0, +)),
         (type: "Calories not eaten yet", amount: 3000 - meals.map {$0.calories}.reduce(0, +))
          ]
    }
    
//    struct ChartData: Identifiable, Equatable {
//        var id: String { return type }
//        
//        let type: String
//        let count: Int
//    }

    
   
    var datarr: [(type: String, amount: Int)] {
        [(type: "Protein", amount: meals.map {$0.protein}.reduce(0, +)),
         (type: "Carbs", amount: meals.map {$0.carbs}.reduce(0, +)),
         (type: "Fat", amount: meals.map {$0.fat}.reduce(0, +)),
          ]
    }
    
    
    var body: some View {
        
//        if (calorieCounter.last?.number) != nil {
//             let numberArray = calorieCounter.map { $0.number }
//            Text("\(String(describing: numberArray.reduce(0, +)))/3000 calories")
//
//        }
        if (meals.isEmpty != true) {
            let numArray = meals.map {$0.protein}
            
            HStack{
                Chart(data, id: \.type) { dataItem in
                    SectorMark(angle: .value("Type", dataItem.amount), innerRadius: .ratio(0.618), angularInset: 1.5)
                        .cornerRadius(5)
                        .foregroundStyle(by: .value("Name", dataItem.amount))
                        .opacity(dataItem.type == "Calories eaten" ? 1 : 0.5 )
                }
                .frame(height:150)
                .chartLegend(.hidden)

            
                .chartBackground { chartProxy in
                  GeometryReader { geometry in
                      let frame = geometry[chartProxy.plotFrame!]
                    VStack {
                        Text("\(String(describing: 3000 - meals.map {$0.calories}.reduce(0, +))) kcal")
                            .foregroundColor(.white)
                        .font(.callout
                            .bold())
//                        .foregroundStyle(.secondary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                  }
                }
                .padding(15)
            
            
                Chart(datarr, id: \.type) { dataPoint in
                
                BarMark(x: .value("Type", dataPoint.type),
                        y: .value("Population", dataPoint.amount), width: 40)
                .foregroundStyle(by: .value("Type", dataPoint.type))
                
                .annotation(position: .overlay) {
                    Text("\(dataPoint.amount)")
                        .foregroundColor(.white)
                }
            }
                .frame(width: 150, height: 150)
//            .chartLegend(.hidden)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .foregroundColor(.white)

                

            .aspectRatio(1, contentMode: .fit)
            .padding()
            }
            
             
         
        }
        

    }
}

@available(iOS 17.0, *)
#Preview {
    HomeView()
        .modelContainer(for: [Meal.self, Count.self], inMemory: true)

}

