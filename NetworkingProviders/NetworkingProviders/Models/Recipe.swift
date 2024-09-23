//
//  Recipe.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

struct RecipeApiResponse: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let image: String?
    
    static var mock: Recipe {
        .init(
            id: 123,
            title: "Test Recipe TItle",
            image: "https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141352.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1726704000&semt=ais_hybrid"
        )
    }
}
