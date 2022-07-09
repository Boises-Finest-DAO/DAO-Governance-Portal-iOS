//
//  GovernVoteModel.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/8/22.
//

struct GovernVoteModel: Identifiable {
    var serial: Int
    var image: String?
    var category: GovernVoteCategories
    var heading: String
    var author: String
    var details: String
    var yesPercent: Double
    var noPercent: Double
    var numberVotes: Int
    var actionType: GovernVoteActions
    
    var id: Int { serial }
}

enum GovernVoteCategories: String {
    case investing = "Investing"
    case governance = "Governance"
}

enum GovernVoteActions: String {
    case manual = "Manual Action"
    case createFund = "Create Investment Fund"
    case disolveFund = "Disolve Investment Fund"
}
