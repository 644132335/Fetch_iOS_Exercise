import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationStack{
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
