//
//  CardView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct GovCardView: View {
    var image: String?
    var category: String
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            if let cardImage = image {
                Image(cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text(author)
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

struct GovCardView_Previews: PreviewProvider {
    static var previews: some View {
        GovCardView(category: "Investments", heading: "Should we move forward with OctoBot", author: "BoiseITGuru")
    }
}
