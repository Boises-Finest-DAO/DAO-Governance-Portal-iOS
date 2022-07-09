//
//  GovernanceView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct GovernanceView: View {
    @State var ballots = [
        GovernVoteModel(serial: 0, category: .governance, heading: "What voting model should we use?", author: "BoiseITGuru", details: "What voting model should we use?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
        GovernVoteModel(serial: 1, category: .governance, heading: "What percentage of total tokens is needed for a qorum?", author: "BoiseITGuru", details: "What percentage of total tokens is needed for a qorum?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
        GovernVoteModel(serial: 2, category: .governance, heading: "What percentage of total votes on an issue are needed for it to pass?", author: "BoiseITGuru", details: "What percentage of total votes on an issue are needed for it to pass?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
        GovernVoteModel(serial: 3, category: .governance, heading: "Let's talk legal entity", author: "BoiseITGuru", details: "How should we track investment funds and contributions?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
        GovernVoteModel(serial: 4, category: .governance, heading: "How should we track investment funds and contributions?", author: "BoiseITGuru", details: "How should we track investment funds and contributions?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
        GovernVoteModel(serial: 5, category: .governance, heading: "Which exchange(s) should we utilize?", author: "BoiseITGuru", details: "How should we track investment funds and contributions?", yesPercent: 0.0, noPercent: 0.0, numberVotes: 0, actionType: .manual),
    ]
    
    var body: some View {
        ZStack {
            List(ballots) { ballot in
                NavigationLink(destination: GovBallotView(ballot: ballot)) {
                    GovCardView(ballot: ballot)
                }
            }
        }
    }
}

struct GovernanceView_Previews: PreviewProvider {
    static var previews: some View {
        GovernanceView()
    }
}
