//
//  MomenthApp.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI
import FirebaseCore
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    return true
  }
}

@main
struct YOMOApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()

        }
        .modelContainer(for: CalendarScheduleModel.self)
    }
}
