//
//  CalendarDateModelExtension.swift
//  YOMO
//
//  Created by 김현중 on 7/3/26.
//

import Foundation

extension CalendarDateModel {
    static var mock = CalendarDateModel(pageIndex: 1200, day: 7, year: 2026, month: 7, isToday: false, isCurrentMonth: 7, type: .current, saturdaySunday: .weekdays)
}

//extension CalendarMonthModel {
//    static var mock = CalendarMonthModel(id: 1, year: 2026, month: 07, dates: <#T##[CalendarDateModel]#>)
//}

extension CalendarMonthViewModel {
    static var mock = CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository())
}

extension ScheduleModel {
    
}
