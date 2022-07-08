//
//  SettingsView.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var fclModel: FCLModel
    
    var body: some View {
        List {
            HStack(spacing: 10) {
                Image("profile")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("BoiseITGuru")
                        .font(.largeTitle)
                    Text("Some other info probably")
                        .font(.subheadline)
                }
            }
            
            Button(action: { fclModel.signOut() }) {
                Text("Sign Out")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
