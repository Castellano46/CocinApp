//
//  LoginView.swift
//  Cocina
//
//  Created by Pedro on 24/1/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    @StateObject private var networkModel = NetworkModel()
    
    var body: some View {
        ZStack {
            Image("CocinApp")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(20)
                    .shadow(radius: 10.0, x:40, y:20)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .opacity(0.8)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(20)
                    .shadow(radius: 10.0, x:40, y:20)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .opacity(0.8)
                
                Button("A Cocinar!!") {
                    let username = "user"
                    let password = "password"

                    networkModel.login(username: username, password: password) { result in
                        switch result {
                        case .success(let message):
                            print(message)
                            networkModel.getRecipes { recipesResult in
                                switch recipesResult {
                                case .success(let recipes):
                                    print("Recipes: \(recipes)")
                                case .failure(let error):
                                    print("Failed to fetch recipes. Error: \(error.localizedDescription)")
                                }
                            }

                        case .failure(let error):
                            print("Login failed. Error: \(error.localizedDescription)")
                        }
                    }
                }
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(width: 170, height: 50)
                .background(Color(uiColor: UIColor(red: 87.0/255.0, green: 35.0/255.0, blue: 100.0, alpha: 1.0)))
                .cornerRadius(20)
                .shadow(radius: 10, x: 20, y:20)
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
