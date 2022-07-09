//
//  CardView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct GovCardView: View {
    var ballot: GovernVoteModel
    
    var body: some View {
        VStack {
            if let cardImage = ballot.image {
                Image(cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(ballot.category.rawValue)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(ballot.heading)
                        .font(.title3)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(ballot.author)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
