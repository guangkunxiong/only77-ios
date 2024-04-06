//
//  Only77App.swift
//  Only77
//
//  Created by yukun xie on 2024/1/31.
//

import SwiftUI

@main
struct Only77App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
