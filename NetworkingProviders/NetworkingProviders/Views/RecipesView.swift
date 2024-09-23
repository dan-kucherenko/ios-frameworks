//
//  FoodRecipesView.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var userInput: String = ""
    @State private var showNutrition: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCell(
                                recipe: recipe,
                                showNutrition: $showNutrition
                            )
                            .environmentObject(viewModel)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(TapGesture().onEnded {
                            print("Sending request")
                            Task {
                                await viewModel.getRecipeDetails(recipeId: recipe.id)
                                
                                guard let recipeDetails = viewModel.selectedRecipeDetails else { return }

                                await viewModel.getCuisine(
                                    dishName: viewModel.selectedRecipeDetails?.title ?? "",
                                    ingredients: recipeDetails.ingredientsFormated
                                )
                            }
                        })
                    }
                }
                .searchable(text: $userInput)
                .onSubmit(of: .search) {
                    Task {
                        await viewModel.getRecipes(userInput: userInput)
                    }
                }
                .navigationTitle("Recipes")
                .navigationDestination(for: Recipe.self) {_ in
                    RecipeDetailsView(
                        recipe: viewModel.selectedRecipeDetails ?? .mock
                    )
                    .environmentObject(viewModel)
                }
            }
        }
        .alert("Recipe Nutrition", isPresented: $showNutrition) {
            Button("OK") {
                showNutrition = false
            }
        } message: {
            Text(viewModel.nutrition?.description ?? "No nutrition info found")
        }
    }
}

#Preview {
    RecipesView()
}
