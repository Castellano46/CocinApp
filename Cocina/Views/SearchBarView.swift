//
//  SearchBarView.swift
//  Cocina
//
//  Created by Pedro on 2/2/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search recipes", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)

            Button(action: {
                print("Search button tapped")
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
            .padding(.leading, 8)
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
