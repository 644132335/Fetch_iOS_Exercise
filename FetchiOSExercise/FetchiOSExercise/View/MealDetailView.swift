import SwiftUI

struct MealDetailView: View {
    var mealId: String
    @ObservedObject var viewModel: MealsViewModel
    
    
    var body: some View {
        ScrollView {
            if let mealDetail = viewModel.mealDetail {
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(mealDetail.strMeal)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        HStack {
                            Text(mealDetail.strCategory)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            
                            Text(mealDetail.strArea)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        
                        if let youtubeURL = mealDetail.strYoutube,
                           let url = URL(string: youtubeURL) {
                            Link("Watch on YouTube", destination: url)
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ForEach(Array(mealDetail.ingredients).indices, id: \.self) { index in
                            Text("• \(mealDetail.ingredients[index])")
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Instructions")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text(mealDetail.strInstructions)
                    }
                    .padding()
                }
            } else {
                ProgressView()
            }
            
        }
        .navigationTitle(viewModel.mealDetail?.strMeal ?? "")
        .onAppear {
            viewModel.fetchMealDetail(by: mealId)
        }
        .onDisappear(){
            viewModel.resetMealDetail()
        }
    }
}

