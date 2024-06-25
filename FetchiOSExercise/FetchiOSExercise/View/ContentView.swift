//
//  ContentView.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationView{
            List(viewModel.meals){ meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal, viewModel: viewModel)){
                    MealRow(meal: meal)
                }
            }.navigationTitle("Recipes")
        }
        .onAppear{
            viewModel.fetchMeals()
        }
    }
}

#Preview {
    ContentView()
}
