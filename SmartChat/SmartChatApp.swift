//
//  SmartChatApp.swift
//  SmartChat
//
//  Created by riccardo ruocco on 30/03/22.
//

import SwiftUI

@main
struct SmartChatApp: App {
    @StateObject var storeSmartChat = StoreSmartChat()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeSmartChat)
        }
    }
}
