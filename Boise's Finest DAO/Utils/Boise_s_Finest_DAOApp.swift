//
//  Boise_s_Finest_DAOApp.swift
//  Boise's Finest DAO
//
//  Created by Brian Pistone on 7/7/22.
//

import SwiftUI

@main
struct Boise_s_Finest_DAOApp: App {
    @StateObject var fclModel = FCLModel()
    @Environment(\.scenePhase) var scenePhase
        
    @State var blurRadius: CGFloat = 0
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fclModel)
                .blur(radius: blurRadius)
                .onChange(of: scenePhase, perform: { value in
                    switch value {
                    case .active :
                        blurRadius = 0
                    case .background:
                        break
                    case .inactive:
                        blurRadius = 5
                    @unknown default:
                        print("unknown")
                    }
                })
        }
    }
}
