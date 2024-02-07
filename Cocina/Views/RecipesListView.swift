//
//  RecipesListView.swift
//  Cocina
//
//  Created by Pedro on 1/2/24.
//

import SwiftUI

struct RecipesListView: View {
    @ObservedObject var viewModel: RecipesListViewModel

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Buscador de recetas
                SearchBar(searchText: $searchText)

                List(viewModel.filteredRecipes(searchText: searchText), id: \.id) { recipe in
                    HStack {
                        AsyncImage(url: URL(string: recipe.image)) { phase in
                            switch phase {
                            case .empty:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            @unknown default:
                                fatalError()
                            }
                        }
                        Text(recipe.title)
                    }
                }
            }
            .navigationBarTitle("Recipes", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.fetchData()
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
                    .foregroundColor(.blue)
            }))
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    let dummyRecipes: [RecipesResult] = [
        RecipesResult(id: 1, title: "Sample Recipe 1", image: "sample_image_1", imageType: .jpg),
        RecipesResult(id: 2, title: "Sample Recipe 2", image: "sample_image_2", imageType: .jpg),
        RecipesResult(id: 3, title: "Sample Recipe 3", image: "sample_image_3", imageType: .jpg)
    ]
    
    let viewModel = RecipesListViewModel()
    viewModel.recipes = dummyRecipes
    
    return RecipesListView(viewModel: viewModel)
}
