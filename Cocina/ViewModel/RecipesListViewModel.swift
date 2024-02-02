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
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                print("Failed to fetch recipes. Error: \(error.localizedDescription)")
            }
        }
    }
}





