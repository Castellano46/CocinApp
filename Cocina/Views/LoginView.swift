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
    @StateObject private var recipesViewModel = RecipesListViewModel()

    @State private var isLogged = false

    var body: some View {
        let bindingIsLogged = Binding(get: { isLogged }, set: { isLogged = $0 })

        NavigationView {
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

                    NavigationLink(
                        destination: RecipesListView(viewModel: recipesViewModel),
                        isActive: bindingIsLogged,
                        label: {
                            Button("A Cocinar!!") {
                                networkModel.login(username: username, password: password) { result in
                                    switch result {
                                    case .success(let message):
                                        print(message)
                                        recipesViewModel.fetchData()

                                        DispatchQueue.main.async {
                                            isLogged = true
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
                    )
                }
                .padding()
                //.navigationTitle("Login")
            }
        }
    }
}

#Preview {
    LoginView()
}
