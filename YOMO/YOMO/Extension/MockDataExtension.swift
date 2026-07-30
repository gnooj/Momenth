//
//  CalendarDateModelExtension.swift
//  YOMO
//
//  Created by 김현중 on 7/3/26.
//

import Foundation

extension CalendarDateModel {
    static var mock = CalendarDateModel(pageIndex: 1200, day: 5, year: 2026, month: 5, isToday: true, isCurrentMonth: 7, type: .current, saturdaySunday: .weekdays)
}

//extension CalendarMonthModel {
//    static var mock = CalendarMonthModel(id: 1, year: 2026, month: 07, dates: <#T##[CalendarDateModel]#>)
//}

extension CalendarMonthViewModel {
    static var mock : CalendarMonthViewModel {
        return CalendarMonthViewModel(
            holidayRepo :HolidayRepository(),
            scheduleRepo: MockScheduleRepository.mock
        )
    }
}

extension MockScheduleRepository {
    static var mock: MockScheduleRepository {
        let now = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 1, to: now) ?? now
        return MockScheduleRepository(schedules: [
            ScheduleModel(title: "첫 일정 야호", startDate: now, endDate: end),
            ScheduleModel(title: "두번째일정", startDate: now, endDate: end),
        ])
    }
}
