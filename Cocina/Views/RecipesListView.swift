//
//  RecipesListView.swift
//  Cocina
//
//  Created by Pedro on 1/2/24.
//

import SwiftUI

struct RecipesListView: View {
    @ObservedObject var viewModel: RecipesListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.recipes, id: \.id) { recipe in
                Text(recipe.title)
            }
            .navigationTitle("Recipes")
        }
    }
}


struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyRecipes: [RecipesResult] = [
            RecipesResult(id: 1, title: "Sample Recipe 1", image: "sample_image_1", imageType: .jpg),
            RecipesResult(id: 2, title: "Sample Recipe 2", image: "sample_image_2", imageType: .jpg),
            RecipesResult(id: 3, title: "Sample Recipe 3", image: "sample_image_3", imageType: .jpg)
        ]

        let viewModel = RecipesListViewModel()
        viewModel.recipes = dummyRecipes

        return RecipesListView(viewModel: viewModel)
    }
}
