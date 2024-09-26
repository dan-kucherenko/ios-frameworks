//
//  Ingredients.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct Nutrition: Codable {
    let calories: String
    let fat: String
    let protein: String
    let carbs: String
    
    var description: String {
        """
            Calories: \(calories), 
            Fat: \(fat), 
            Protein: \(protein), 
            Carbs: \(carbs)
        """
    }
    
    static var mock: Nutrition {
        Nutrition(
            calories: "mock calories",
            fat: "mock fat",
            protein: "mock protein",
            carbs: "mock carbs"
        )
    }
}
