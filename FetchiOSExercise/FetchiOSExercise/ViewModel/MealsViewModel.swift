//
//  MealsViewModel.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 6/25/24.
//

import Foundation

class MealsViewModel: ObservableObject{
    @Published var meals: [Meal] = []
    @Published var mealDetail: MealDetail?
    
    func fetchMeals() {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching meals: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(Meals.self, from: data) {
                DispatchQueue.main.async {
                    self?.meals = decodedResponse.meals.sorted(by: { $0.strMeal < $1.strMeal })
                }
            }
        }.resume()
    }
    
    func fetchMealDetail(by id: String) {
            let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching meal details: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data),
                   let mealDetail = decodedResponse.meals.first {
                    DispatchQueue.main.async {
                        self?.mealDetail = mealDetail
                    }
                }
            }.resume()
        }
    
}
