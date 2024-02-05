//
//  NetworkModel.swift
//  Cocina
//
//  Created by Pedro on 23/1/24.
//

import Foundation
import Combine

final class NetworkModel: ObservableObject {
    private var apiKey: String? {
        return UserSettings.shared.apiKey
    }

    enum NetworkError: Error {
        case unknown
        case decodingFailed
        case noApiKey
        case statusCode(code: Int)
    }

    private var baseURL: URL {
        return URL(string: "https://api.spoonacular.com")!
    }

    func login(username: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let obtainedApiKey = "2ff61fcbcaed4e05b271c47746b86b8f"
        //let obtainedApiKey = "d75de7fd321846f3b0f3e5fd1d42ba86"

        UserSettings.shared.apiKey = obtainedApiKey
        completion(.success("Login successful"))
    }

    func getRecipes(completion: @escaping (Result<[RecipesResult], NetworkError>) -> Void) {
        guard let apiKey = self.apiKey else {
            completion(.failure(.noApiKey))
            return
        }

        let url = baseURL.appendingPathComponent("/recipes/complexSearch")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "apiKey", value: apiKey)]

        guard let finalURL = components?.url else {
            completion(.failure(.unknown))
            return
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }

            if (200...299).contains(httpResponse.statusCode) {
                guard let data = data else {
                    completion(.failure(.decodingFailed))
                    return
                }

                do {
                    let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                    completion(.success(recipes.results))
                } catch {
                    print("Decoding failed. Error: \(error)")
                    completion(.failure(.decodingFailed))
                }
            } else if httpResponse.statusCode == 401 {
                print("Unauthorized. API key may be invalid or lacks necessary permissions.")
                completion(.failure(.statusCode(code: 401)))
            } else {
                print("HTTP Request failed. Status code: \(httpResponse.statusCode)")
                completion(.failure(.statusCode(code: httpResponse.statusCode)))
            }
        }

        print("Making network request to: \(finalURL)")
        task.resume()
    }
}
