//
//  ContentView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                DashboardView()
                    .tabItem {
                        Image(systemName: "greetingcard.fill")
                        Text("Dashboard")
                    }
                PortfolioView()
                    .tabItem {
                        Image(systemName: "dollarsign.circle.fill")
                        Text("Portfolio")
                    }
                GovernanceView()
                    .tabItem {
                        Image(systemName: "folder.badge.person.crop")
                        Text("Governance")
                    }
            }
            .navigationBarTitle("Boise's Finest DAO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "person.circle")
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
