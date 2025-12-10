//
//  CreateMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/12/25.
//

import Foundation


class CalendarDateGenerator {
//    let vm = CalendarMonthViewModel()
    let formatter = DateFormatter()

    var calendar = Calendar.current
    var idCount = 1
    
    func createMonths(for index : Int) -> CalendarMonthModel {
        let offset = index - Global.CENTER_PAGE
        
        let date  = calendar.date(byAdding: .month, value: offset, to: .now)!
        formatter.dateFormat = "yyyy-MM"
        
        
//        let date = calendar.date(byAdding: .month, value: index, to: .now)!
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        // MARK:    강제 언래핑
        
        
        let dates = createDates(year : year, month : month, date : date)
//---------------------- idCount 뭐가 바꿔야 할 거 같음
        idCount += 1
       
        return CalendarMonthModel(id: idCount, year:year, month: month, dates: dates)
    }
    
    private func createDates(year : Int ,month: Int, date: Date) -> [CalendarDateModel] {
        
        let monthRange = calendar.range(of: .day, in: .month, for: date)
        guard let monthSize = monthRange?.count else { return [] }
        
        //달의 1일의 요일 계산 (1=일,2=월 ...)

        

//        var prevMonthDateCount = firstWeekday - 1
//        var nextMonthDateCount : Int { return 7-((prevMonthDateCount + monthSize) % 7) }
//        var prevMonthRange : Int {
//            
//            guard let temp = calendar.date(byAdding: .month, value: -1, to: date) else {return 0}
//            guard let ragneOfPrevMonth = calendar.range(of: .day, in: .month, for: temp) else { return 0 }
//            return ragneOfPrevMonth.count
//            
//        }
        
        
        var dates: [CalendarDateModel] = []
        // 전 달 일자 채워넣기
        
        
        
        for i in 1...monthSize {
            
            dates.append(CalendarDateModel(id: i ,day: i, year:year, month:month, isToday: true, isSelected: true, isCurrentMonth: 9))
            //오늘을 어떻게 할지 고민해봐야함
            
        }
        //다음달 일자 채워넣기
        
        
        
        
        return dates
        
    }
    
}
