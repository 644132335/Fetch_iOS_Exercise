import Foundation
import Combine

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetail: MealDetail?
    
    // Storing the subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch all meals
    func fetchMeals() {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Meals.self, decoder: JSONDecoder())
            .map { $0.meals.sorted(by: { $0.strMeal < $1.strMeal }) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching meals: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] meals in
                self?.meals = meals
            })
            .store(in: &cancellables)
    }
    
    // Fetch one detail meal by ID
    func fetchMealDetail(by id: String) {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MealDetailResponse.self, decoder: JSONDecoder())
            .compactMap { $0.meals.first }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching meal details: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] mealDetail in
                self?.mealDetail = mealDetail
            })
            .store(in: &cancellables)
    }
    
    // Reset the meal detail
    func resetMealDetail(){
        mealDetail = nil
    }
}
