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
                    ForEach(viewModel.recipes ?? [.mock], id: \.self) { recipe in
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
                            }
                        })
                    }
                }
                .searchable(text: $userInput)
                .navigationTitle("Recipes")
                .navigationDestination(for: Recipe.self) {_ in
                    RecipeDetailsView(
                        recipe: viewModel.selectedRecipeDetails
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
            Text(viewModel.nutrition.description)
        }
        .task {
            await viewModel.getRecipes(userInput: userInput)
        }
    }
}

#Preview {
    RecipesView()
}
