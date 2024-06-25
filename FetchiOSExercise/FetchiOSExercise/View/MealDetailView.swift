//
//  MealDetailView.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 6/25/24.
//

import SwiftUI

struct MealDetailView: View {
    var mealId: String
    @ObservedObject var viewModel: MealsViewModel
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: viewModel.mealDetail?.strMealThumb ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .clipped()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.mealDetail?.strMeal ?? "Loading...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(viewModel.mealDetail?.strCategory ?? "")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                        
                        Text(viewModel.mealDetail?.strArea ?? "")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                    if let youtubeURL = viewModel.mealDetail?.strYoutube,
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
                    
                    ForEach(viewModel.mealDetail?.ingredients ?? [], id: \.self) { ingredient in
                        Text("• \(ingredient)")
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(viewModel.mealDetail?.strInstructions ?? "")
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.mealDetail?.strMeal ?? "Meal Details")
        .onAppear {
            viewModel.fetchMealDetail(by: mealId)
        }
    }
}

