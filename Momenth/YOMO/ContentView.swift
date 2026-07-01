//
//  ContentView.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject private var calendarMonthVM = CalendarMonthViewModel()
    
    
    var body: some View {
        
        MainTabView(calendarMonthVM: calendarMonthVM)

    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

