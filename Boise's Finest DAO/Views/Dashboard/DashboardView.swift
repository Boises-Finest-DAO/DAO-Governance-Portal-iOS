//
//  Dashboard.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var fclModel: FCLModel
    
    var body: some View {
        VStack {
            Text("Dashboard")
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
