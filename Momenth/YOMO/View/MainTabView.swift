//
//  TabView.swift
//  Momenth
//
//  Created by 김현중 on 12/21/25.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    var body: some View {
        
        TabView {
              MonthView(calendarMonthVM: calendarMonthVM)
                .tabItem {
                  Image(systemName: "1.square.fill")
                  Text("Momenth")
                }
              Text("Another Tab")
                .tabItem {
                  Image(systemName: "2.square.fill")
                  Text("Challenge")
                }
              Text("The Last Tab")
                .tabItem {
                  Image(systemName: "3.square.fill")
                  Text("Third")
                }
                .badge(10)
            }
//        .tabViewStyle()
        }

    }


#Preview {
    MainTabView(calendarMonthVM:CalendarMonthViewModel())
}
