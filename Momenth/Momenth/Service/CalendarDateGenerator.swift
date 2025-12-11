//
//  CreateMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/12/25.
//

import Foundation


class CalendarDateGenerator {
    var calendar = Calendar.current
    var idCount = 1
    let today : Int
    let thisMonth : Int
    var thisYear : Int

    
    init() {
        calendar.firstWeekday = 1
        today = calendar.component(.day, from: .now)
        thisMonth = calendar.component(.month, from: .now)
        thisYear  = calendar.component(.year, from: .now)
        
    }
    
    func createMonths(for index : Int) -> [CalendarDateModel] {
        let types : [CalendarDateModel.DayType] = [.previous,.current,.next]
        let offset = index - Global.CENTER_PAGE
        let standardDate = calendar.date(byAdding: .month, value: offset, to: .now)!
        let standardDateCount = calendar.range(of: .day, in: .month, for: standardDate)!.count
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: standardDate))!
        let firstWeekday = calendar.component(.weekday, from: firstDay)
//        print("firstDay === \(firstDay)")
        

        var dates: [CalendarDateModel] = []

        for i in -1...1 {
            // MARK: 강제 언레핑사용중
            let date = calendar.date(byAdding: .month, value: offset+i, to: .now)!
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            dates.append(contentsOf: createDates(firstWeekday: firstWeekday,standardDateCount:standardDateCount,year: year, month: month,type:types[i+1] ,date : date))
        }
        
        
        
        //---------------------- idCount 뭐가 바꿔야 할 거 같음
        idCount += 1
        
        return dates
    }
    
    private func createDates(firstWeekday: Int,standardDateCount : Int,year : Int, month: Int ,type : CalendarDateModel.DayType, date: Date) -> [CalendarDateModel] {
        
        
        let monthRange = calendar.range(of: .day, in: .month, for: date)
        
        guard let monthSize = monthRange?.count else { return [] }
        
        var dates: [CalendarDateModel] = []
        
        
        switch type {
            case .previous:
            for i in (monthSize - firstWeekday+2)..<(monthSize + 1) {
                    dates.append(CalendarDateModel(id: i ,day: i, year:year, month:month, isToday: false, isSelected: false, isCurrentMonth: thisMonth,type: type))
//                print("dkfksdjfksdjf")
            }

            case .current:
            for i in 1...monthSize {
                
                if year == thisYear && month == thisMonth && i == today {
                    dates.append(CalendarDateModel(id: i ,day: i, year:year, month:month, isToday: true, isSelected: true, isCurrentMonth: thisMonth,type: type))
                }else {
                    dates.append(CalendarDateModel(id: i ,day: i, year:year, month:month, isToday: false, isSelected: false, isCurrentMonth: thisMonth,type: type))
                }
                
            }

            case .next:
            let minus = 7-(((firstWeekday-1)+standardDateCount)%7)
            if (minus==7){
                break
            }else{
                for i in 1...minus{
                        dates.append(CalendarDateModel(id: i ,day: i, year:year, month:month, isToday: false, isSelected: false, isCurrentMonth: thisMonth,type: type))
                }
            }

        }
        
        //다음달 일자 채워넣기
        return dates
    }
}
