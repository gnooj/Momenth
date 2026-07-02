//
//  ContentView.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var calendarMonthVM = CalendarMonthViewModel()
    
    
    var body: some View {
        
        MainTabView(calendarMonthVM: calendarMonthVM)

    }
    
}




#Preview {
    ContentView()
}

