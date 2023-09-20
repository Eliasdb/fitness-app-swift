//
//  WeightTrackerView.swift
//  Dawn
//
//  Created by Elias on 20/09/2023.
//

import SwiftUI
import SwiftData
import Charts

@available(iOS 17.0, *)
struct WeightTrackerView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var vm = ViewModel()
    @Query private var weights: [Weight]
    @Binding var weightDay: Date
    @Binding var weight: Double

    var body: some View {
        Section {
            NavigationLink {
                VStack {
                    Form {
                        Section {
                            if vm.getWeights(weights: weights).isEmpty {
                                Text("No data yet...")
                            } else {
                                Chart {
                                    ForEach(vm.getWeights(weights: weights).sorted(by: { $0.dateasDate < ($1.dateasDate)}) , id: \.self) { item in
                                        LineMark(x: .value("day", item.date), y: .value("amount", item.amount))
                                            .foregroundStyle(Color("TestColor").gradient)
                                    }
                                }
                                .chartScrollableAxes(.horizontal)
//                                        .chartXVisibleDomain(length: -2)
                                .chartScrollPosition(initialX: vm.getDateString(date: weightDay))
//                                .chartScrollTargetBehavior(
//                                    .valueAligned(matching: .init(hour:0), majorAlignment: .matching(.init(day:1)))
//                                )
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
    }
}

//#Preview {
//    WeightTrackerView()
//}
