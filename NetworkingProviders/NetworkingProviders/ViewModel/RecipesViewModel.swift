//
//  RecipeViewModel.swift
//  NetworkingProviders
//
//  Created by Daniil on 21.09.2024.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe]?
    @Published var nutrition: Nutrition?
    @Published var selectedRecipeDetails: RecipeDetails?
    @Published var cuisine: Cuisine?
    
    private  var networkingProvider: NetworkingProvider = AlamofireNetworkManager()
    
    // MARK: - Get recipes by user input
    func getRecipes(userInput: String) async {
        do {
            recipes = try await networkingProvider.searchRecipes(recipeName: userInput)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get recipe details
    func getRecipeDetails(recipeId: Int) async {
        do {
            selectedRecipeDetails = try await networkingProvider.getDetailedRecipe(id: recipeId)
        } catch {
            selectedRecipeDetails = nil
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get nutrition info by dish name
    func getNutrition(dishName: String) async {
        do {
            nutrition = try await networkingProvider.guessNutrition(dishName: dishName)
        } catch {
            nutrition = nil
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Get cuisine name by dish name and ingredients
    func getCuisine(dishName: String, ingredients: String) async {
        do {
            cuisine = try await networkingProvider.classifyCuisine(dishName: dishName, ingredients: ingredients)
        } catch {
            cuisine = nil
            print(error.localizedDescription)
        }
    }
}
