//
//  AddScheduleView.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import SwiftUI

struct AddScheduleView: View {
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    var body: some View {
                VStack{
                    Rectangle()
                        .cornerRadius(50)
                        .containerRelativeFrame(.horizontal) { width, _ in
                            width * 0.8
                        }
                        .containerRelativeFrame(.vertical) { height, _ in
                            height * 0.6
                        }
                        .foregroundStyle(Color.accentColor)
                }
    }
}

#Preview {
    AddScheduleView(calendarMonthVM:CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository()))
}
