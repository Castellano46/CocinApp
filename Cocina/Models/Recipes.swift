//
//  Recipes.swift
//  Cocina
//
//  Created by Pedro on 23/1/24.
//

import Foundation

struct Recipes: Codable {
    let results: [RecipesResult]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct RecipesResult: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
    case png = "png"
}
