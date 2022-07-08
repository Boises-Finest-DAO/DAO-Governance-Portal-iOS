//
//  ContentView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fclModel: FCLModel
    @State var showSettings = false
    
    var body: some View {
        NavigationView {
            if fclModel.address == "" {
                SignIn()
            } else {
                TabView {
                    DashboardView()
                        .tabItem {
                            Image(systemName: "greetingcard.fill")
                            Text("Dashboard")
                        }
                    TreasureyView()
                        .tabItem {
                            Image(systemName: "dollarsign.circle.fill")
                            Text("Portfolio")
                        }
                    OctoBotsView()
                        .tabItem {
                            Image(systemName: "pc")
                            Text("Octobots")
                        }
                    GovernanceView()
                        .tabItem {
                            Image(systemName: "folder.badge.person.crop")
                            Text("Governance")
                        }
                }
                .accentColor(Color(hex: "4bb17b"))
                .sheet(isPresented: $showSettings, content: {
                    SettingsView()
                })
                .navigationBarTitle("Boise's Finest DAO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showSettings.toggle() }) {
                            Image(systemName: "person.circle")
                                .foregroundColor(Color(hex: "4bb17b"))
                        }
                    }
                }
            }
        }
        .onAppear(perform: fclModel.faceIdAuth)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
