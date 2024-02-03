//
//  RecipesListViewModel.swift
//  Cocina
//
//  Created by Pedro on 1/2/24.
//

import Foundation
import Combine

final class RecipesListViewModel: ObservableObject {
    @Published var recipes: [RecipesResult] = []
    
    private var networkModel: NetworkModel

    private var cancellables: Set<AnyCancellable> = []

    init(networkModel: NetworkModel = NetworkModel()) {
        self.networkModel = networkModel
        fetchData()
    }

    func fetchData() {
        networkModel.getRecipes { result in
            switch result {
            case .success(let fetchedRecipes):
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                }
            case .failure(let error):
                print("Failed to fetch recipes. Error: \(error.localizedDescription)")
            }
        }
    }

    func filteredRecipes(searchText: String) -> [RecipesResult] {
        guard !searchText.isEmpty else {
            return recipes
        }

        return recipes.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
}
