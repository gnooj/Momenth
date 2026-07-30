//
//  ContentView.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI

struct ContentView: View {
    let holidayRepo : HolidayRepository
    let scheduleRepo : ScheduleRepository
    
    @StateObject private var calendarMonthVM : CalendarMonthViewModel
    init(holidayRepo: HolidayRepository, scheduleRepo: ScheduleRepository) {
            self.holidayRepo = holidayRepo
            self.scheduleRepo = scheduleRepo
            _calendarMonthVM = StateObject(wrappedValue: CalendarMonthViewModel(
                holidayRepo: holidayRepo,
                scheduleRepo: scheduleRepo
            ))
        }
    var body: some View {
        
        MainTabView(calendarMonthVM: calendarMonthVM)
            .task {
                calendarMonthVM.loadInitialHolidays()
            }

    }
    
}




#Preview {
    ContentView(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository())
}

