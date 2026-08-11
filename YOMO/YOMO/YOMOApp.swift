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
    private let modelContainer : ModelContainer
    @StateObject private var holidayRepository : HolidayRepository
    @StateObject private var scheduleRepository : ScheduleRepository
    
    init() {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for : ScheduleModel.self,configurations: configuration)
            self.modelContainer = container
            _holidayRepository = StateObject(wrappedValue: HolidayRepository())
            _scheduleRepository = StateObject(wrappedValue: ScheduleRepository(context: container.mainContext))
        }catch {
            fatalError("modelcontainer 생성 실패\(error)")
        }

        
    }
    

        
        
        

    
    var body: some Scene {
        WindowGroup {
            ContentView(holidayRepo: holidayRepository, scheduleRepo: scheduleRepository)
                .environment(\.locale, Locale(identifier: "ko_KR"))

        }
        .modelContainer(modelContainer)
    }
}
