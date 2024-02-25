//
//  FavoriteButtonView.swift
//  DevHub
//
//  Created by Adolfo Calderon on 2/24/24.
//

import SwiftUI

struct FavoriteButtonView: View {
    @State private var isFavorited = false

    var body: some View {
        VStack {
            // Favorites button
            Button(action: {
                isFavorited.toggle()
            }) {
                Image(systemName: isFavorited ? "star.fill" : "star")
                    .foregroundColor(isFavorited ? .yellow : .gray)
                    .aspectRatio(contentMode: .fill)
            }
            .animation(.easeIn, value: isFavorited)
        }
    }
}

