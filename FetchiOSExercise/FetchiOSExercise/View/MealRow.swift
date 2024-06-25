//
//  MealRow.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 6/25/24.
//

import SwiftUI

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(meal.strMeal)
        }
    }
}
