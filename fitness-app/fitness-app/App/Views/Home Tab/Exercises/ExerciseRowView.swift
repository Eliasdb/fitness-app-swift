//
//  ExerciseRowView.swift
//  Dawn
//
//  Created by Elias on 25/07/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct ExerciseRowView: View {
    @Environment(\.modelContext) private var context
    @State private var exerciseToEdit: Exercise?
    @Bindable var exercise: Exercise


    var body: some View {
        HStack(alignment: .top, spacing: 0) {
//            Circle()
//                .fill(.black)
//                .frame(width: 10, height: 10)
//                .padding(5)
//                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
//                .offset(y: 16)
//                .offset(x: -15)

          
            VStack(alignment: .leading, spacing: 8, content: {
                Text(exercise.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                Label("\(exercise.sets) sets", systemImage: "fork.knife.circle")
                    .font(.subheadline)
                    .foregroundStyle(.black)
                
            })
           
            .padding(15)
            .hSpacing(.leading)
            .background(Color(.white), in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contentShape(.contextMenuPreview,.rect(cornerRadius: 15) )
            .contextMenu {
                Button("Delete exercise", role: .destructive) {
                    context.delete(exercise)
                    try? context.save()
                }
                Button("Update meal") {
                  exerciseToEdit = exercise
                }
            }
            .offset(y: -8)
        }
       
//    
        
    }
}

@available(iOS 17.0, *)
struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .modelContainer(for: [Meal.self], inMemory: true)

    }
}
