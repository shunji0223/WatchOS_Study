//
//  hakkasonnApp.swift
//  hakkasonn WatchKit Extension
//
//  Created by 朱駿璽 on 2021/12/02.
//

import SwiftUI

@main
struct hakkasonnApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
