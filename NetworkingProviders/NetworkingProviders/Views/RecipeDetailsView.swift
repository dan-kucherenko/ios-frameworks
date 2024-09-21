//
//  FoodRecipeDetailsView.swift
//  NetworkingProviders
//
//  Created by Daniil on 19.09.2024.
//

import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    let recipe: RecipeDetails
    @EnvironmentObject var viewModel: RecipesViewModel
    @State var showNutrition: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(URL(string: recipe.image))
                    .resizable()
                    .scaledToFit()
                
                header
                
                Divider()
                
                Text(recipe.summary)
                    .padding()
            }
        }
        .ignoresSafeArea()
        .alert("Recipe Nutrition", isPresented: $showNutrition) {
            Button("OK") {
                showNutrition = false
            }
        } message: {
            Text(viewModel.nutrition.description)
        }
    }
}

extension RecipeDetailsView {
    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.title2)
                    .bold()
                Text("Cuisine: \(viewModel.cuisine.cuisineName)")
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    
                    Text("\(recipe.readyInMinutes.description)min")
                }
                Button("Nutrition") {
                    Task {
                        await viewModel.getNutrition(dishName: recipe.title)
                        showNutrition = true
                    }
                }
                .tint(.primary)
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

#Preview {
    RecipeDetailsView(recipe: .mock)
}
