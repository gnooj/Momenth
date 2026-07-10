//
//  CreateMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/12/25.
//

import Foundation


class CalendarDateGenerator {
    var calendar = Calendar.current
    let today : Int
    let thisMonth : Int
    var thisYear : Int
    var callcounter : Int = 0
    var todayDateModel : CalendarDateModel = CalendarDateModel(pageIndex: 1, day: 1, year: 1, month: 1, isToday: false, isCurrentMonth: 1, type: .current, saturdaySunday: .sunday)
    
    init() {
        calendar.firstWeekday = 1
        today = calendar.component(.day, from: .now)
        thisMonth = calendar.component(.month, from: .now)
        thisYear  = calendar.component(.year, from: .now)
        
    }
    
    func createMonths(for index : Int) -> [CalendarDateModel] {
        Global.count = Global.count + 1
        print("createMonths CALL\(Global.count)")
//        print("call!---- \(callcounter)")
        callcounter += 1
        let dayTypes : [CalendarDateModel.DayType] = [.previous,.current,.next]
//        var saturdaySunday : [CalendarDateModel.SaturdaySunday] = [.saturday,.sunday,.weekdays]
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
            let saturdaySundayType = CalendarDateModel.SaturdaySunday.weekdays
            
            dates.append(contentsOf: createDates(index: index,firstWeekday: firstWeekday,standardDateCount:standardDateCount,year: year, month: month,type:dayTypes[i+1],saturdaySunday:saturdaySundayType ,date : date))
        }
        for i in 0 ..< dates.count{
            let column = i % 7
            
            if column == 0 {
                dates[i].saturdaySunday = .sunday
            } else if column == 6 {
                dates[i].saturdaySunday = .saturday
            }
        }
//        print("ganerator call dates ========\(dates)")
        return dates
    }
    
    private func createDates(index: Int,firstWeekday: Int,standardDateCount : Int,year : Int, month: Int ,type : CalendarDateModel.DayType, saturdaySunday: CalendarDateModel.SaturdaySunday,date: Date) -> [CalendarDateModel] {
        
        Global.count = Global.count + 1
        print("createDates CALL\(Global.count)")
        
        let monthRange = calendar.range(of: .day, in: .month, for: date)
        
        guard let monthSize = monthRange?.count else { return [] }
        
        var dates: [CalendarDateModel] = []
        
        
        switch type {
            case .previous:
            for i in (monthSize - firstWeekday+2)..<(monthSize + 1) {
                dates.append(CalendarDateModel(pageIndex: index, day: i, year: year, month: month, isToday: false, isCurrentMonth: thisMonth,type: type,saturdaySunday: saturdaySunday))
//                print("dkfksdjfksdjf")
            }
//            print()
//            print("generator dic KEY == \((((year*100)+month)*100)+1)")
//            print("holidaysMap ===== \(holidaysMap)")
//            print()
            
            case .current:
            for i in 1...monthSize {
                
                if year == thisYear && month == thisMonth && i == today {
                    dates.append(CalendarDateModel(pageIndex:index,day: i, year:year, month:month, isToday: true,  isCurrentMonth: thisMonth,type: type,saturdaySunday: saturdaySunday))
                    todayDateModel = CalendarDateModel(pageIndex:index,day: i, year:year, month:month, isToday: true,  isCurrentMonth: thisMonth,type: type,saturdaySunday: saturdaySunday)
                }else {
                    dates.append(CalendarDateModel(pageIndex:index,day: i, year:year, month:month, isToday: false,  isCurrentMonth: thisMonth,type: type,saturdaySunday: saturdaySunday))
                }
                
            }

            case .next:
            let minus = 7-(((firstWeekday-1)+standardDateCount)%7)
            if (minus==7){
                break
            }else{
                for i in 1...minus{
                        dates.append(CalendarDateModel(pageIndex:index,day: i, year:year, month:month, isToday: false,  isCurrentMonth: thisMonth,type: type,saturdaySunday: saturdaySunday))
                }
            }

        }
        
        
        //다음달 일자 채워넣기
        return dates
    }
    func uqdateToday() -> CalendarDateModel {
        
        return todayDateModel
    }

}
