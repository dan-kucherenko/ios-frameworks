//
//  FoodRecipeCell.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

import SwiftUI
import Kingfisher

struct RecipeCell: View {
    let recipe: Recipe
    
    @EnvironmentObject var viewModel: RecipesViewModel
    @Binding var showNutrition: Bool
    
    var body: some View {
        VStack {
            if let recipeImage = recipe.image {
                KFImage(URL(string: recipeImage))
                    .resizable()
                    .scaledToFit()
            }
            
            footer
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.gray, lineWidth: 3)
        )
        .padding()
    }
}

extension RecipeCell {
    private var footer: some View {
        HStack {
            Text(recipe.title)
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button("Nutrition") {
                Task {
                    await viewModel.getNutrition(dishId: recipe.id)
                    showNutrition = true
                }
            }
            .tint(.primary)
            .background()
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    RecipeCell(
        recipe: Recipe.mock,
        showNutrition: .constant(true)
    )
}
