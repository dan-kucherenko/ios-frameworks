//
//  Ingredients.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct Nutrition: Decodable {
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
            calories: "123",
            fat: "456",
            protein: "678",
            carbs: "987"
        )
    }
}
