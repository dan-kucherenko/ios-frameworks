//
//  Ingredients.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct Nutrition: Decodable {
    let calories: NutritionParts
    let fat: NutritionParts
    let protein: NutritionParts
    let carbs: NutritionParts
    
    var description: String {
        """
            Calories: \(calories.value), 
            Fat: \(fat.value), 
            Protein: \(protein.value), 
            Carbs: \(carbs.value)
        """
    }
}

struct NutritionParts: Decodable {
    let value: Double
}

