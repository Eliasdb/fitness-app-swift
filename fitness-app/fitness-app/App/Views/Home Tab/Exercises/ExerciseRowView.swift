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
    @Binding var currentDate: Date
    @Binding var categories: [String : [(name: String, sets: Int, reps: Int)]]

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 8, content: {
                Text(exercise.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
                Label("\(exercise.totalAmount) sets", systemImage: "fork.knife.circle")
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
                Button("Update exercise") {
                  exerciseToEdit = exercise
                }
            }
            .offset(y: -8)
            .sheet(item: $exerciseToEdit) {
                exerciseToEdit = nil
            } content: { meal in
                UpdateExerciseView(exercise: exercise, currentDate: $currentDate, categories: $categories)
                    .presentationDetents([.height(520)])
                    .interactiveDismissDisabled()
                    .presentationCornerRadius(30)
                    .presentationBackground(.gray)
            }
        }
    }
}

//@available(iOS 17.0, *)
//struct ExerciseRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .modelContainer(for: [Meal.self], inMemory: true)
//    }
//}
