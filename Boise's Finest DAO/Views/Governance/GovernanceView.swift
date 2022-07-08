//
//  GovernanceView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct GovernanceView: View {
    var body: some View {
        ZStack {
            ScrollView {
                GovCardView(category: "Investing", heading: "Move Investments to Binance", author: "BoiseITGuru")
                GovCardView(category: "Governance", heading: "Do we want Pizza at the next meeting", author: "BoiseITGuru")
            }
        }
    }
}

struct GovernanceView_Previews: PreviewProvider {
    static var previews: some View {
        GovernanceView()
    }
}
