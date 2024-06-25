//
//  MealModel.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 6/25/24.
//

import Foundation

struct Meals: Codable{
    let meals: [Meal]
}

struct Meal: Codable,Identifiable{
    var id: String {idMeal}
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String?
    let strSource: String?
    var ingredients: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strYoutube, strSource
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        
        let baseContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for i in 1...20 {
            guard let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
                  let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)") else {
                continue 
            }
            
            if let ingredient = try baseContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmpty,
               let measure = try baseContainer.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmpty {
                ingredients.append("\(ingredient): \(measure)")
            }
        }
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
    }
}
