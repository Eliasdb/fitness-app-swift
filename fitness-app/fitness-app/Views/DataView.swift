//
//  DataView.swift
//  Dawn
//
//  Created by Elias on 24/07/2023.
//

import SwiftUI


// A struct to store exactly one restaurant's data.
//struct Meal: Identifiable {
//    let id = UUID()
//    var name: String
//    var calories: Int
////    var carbs: Int
////    var fat: Int
////    var sugar: Int
////    var protein: Int
//}



// A view that shows the data for one Restaurant.
//struct MealRow: View {
//    var meal: Meal
//
//    var body: some View {
//        HStack {
//            Text("\(meal.name)")
//            Text("\(meal.calories) calories")
//
//        }
//
//    }
//}

// Create three restaurants, then show them in a list.
struct DataView: View {
//    @State private var mealName: String = ""
//    @State private var calories: Int = 0
//    @State private var carbs: Int = 0
//    @State private var fat: Int = 0
//    @State private var sugar: Int = 0
//    @State private var protein: Int = 0
//
//    private let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()


//    @State var meals = [
////        Meal(name: "Chicken", carbs: 4, fat: 4, sugar: 0, protein: 5),
//        Meal(name: "Rice", calories: 2),
//        Meal(name: "Potato", calories: 20)
//    ]

    var body: some View {
        Text("test")
//        NavigationStack {
//            Form {
//                List(meals) { meal in
//
//                    MealRow(meal: meal)
//
//                }
//                TextField("Meal", text: $mealName)
//                TextField("Calories", value: $calories, formatter: self.formatter )
//
//
//            }
//
//            .navigationBarTitle("Meals")
//            .navigationBarItems(trailing:
//                Button(action: {
//                    print("Add button pressed...")
//                let newMeal = Meal(name: mealName, calories: calories)
//                mealName = "";
//                meals.append(newMeal)
//
//                print(calories)
//
//
//                calories = 0;
//                }) {
//                    Text("Add")
//                }
//            )
//        }


        }
}

//struct DataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataView()
//    }
//}
