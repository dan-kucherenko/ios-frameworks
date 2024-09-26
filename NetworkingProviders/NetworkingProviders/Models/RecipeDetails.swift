//
//  RecipeDetails.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct RecipeDetails: Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let summary: String
    let extendedIngredients: [Ingredient]
    
    static var mock: Self {
        RecipeDetails(
            id: 123,
            title: "123",
            readyInMinutes: 123,
            image: "asdasd",
            summary: "asdadad",
            extendedIngredients: []
        )
    }
    
    var ingredientsFormated: String {
        var formattedIngredients: String = ""
        extendedIngredients.forEach { ingredient in
            let metric = ingredient.measures.metric
            formattedIngredients += "\(metric.amount) \(metric.unitShort) \(ingredient.name)\n"
        }
        return formattedIngredients
    }

}

struct Ingredient: Codable {
    let id: Int
    let name: String
    let measures: Measures
    
    struct Measures: Codable {
        let metric: Metric
        
        struct Metric: Codable {
            let amount: Double
            let unitShort: String
        }
    }
}




