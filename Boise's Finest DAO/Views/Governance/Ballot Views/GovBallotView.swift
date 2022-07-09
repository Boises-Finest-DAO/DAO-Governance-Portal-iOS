//
//  GovBallotView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/8/22.
//

import SwiftUI

struct GovBallotView: View {
    var ballot: GovernVoteModel
    
    var body: some View {
        ScrollView {
            if let ballotImage = ballot.image {
                VStack {
                    Image(ballotImage)
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .bottomLeading) {
                            ImageOverlay(text: ballot.heading, font: .title)
                        }
                        .padding(.bottom)
                }
            } else {
                Text(ballot.heading)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .padding(.bottom)
            }
            
            Text(ballot.category.rawValue)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            Text(ballot.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom)
            
            Text(ballot.details)
                .font(.body)
                .padding(.bottom)
            
        }
    }
}
