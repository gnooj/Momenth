//
//  CreateMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/12/25.
//

import Foundation


class CalendarDateGenerator {
    
    var calendar = Calendar.current
    
    
    //    var isToday: (Int, Int,Int) {
    //        let toDay = calendar.component(.day, from: Date())
    //        let month = calendar.component(.month, from: Date())
    //        let year = calendar.component(.year, from: Date())
    //        return (toDay,month,year)
    //    }
    //    var toDayAndWeekday: (Int, Int) {
    //        let toDay = calendar.component(.day, from: Date())
    //        let weekday = calendar.component(.weekday, from: Date())
    //        return (toDay, weekday)
    //    }
    
    //현재 달의 첫날과 마지막날만큼 일자 생성
    //isToday와 currentmonth설정까지 해주기
    func createMonthViewModel() -> CalendarMonthModel {
        
        let year = calendar.component(.year, from: Date())
        let month = calendar.component(.month, from: Date())
        let dates = createDates()
        //
        // 특정 년/월/일만 지정 (시간은 00:00:00)
       
        
        let result = CalendarMonthModel(year: year, month: month, dates: dates)
        
        return result
    }
    
    private func createDates() -> [CalendarDateModel] {
        

        var dates: [CalendarDateModel] = []
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: Date()) else {
            
            return []
            
        }
        
        print("\(monthInterval)")
        
        let lastDayOfMonth = calendar.date(byAdding: .day, value: -1, to: monthInterval.end)!
        let monthSize = calendar.component(.day, from: lastDayOfMonth)
        
        //        let formatter = DateFormatter()
        //            formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        //            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //
        //            print("첫날 (한국시간): \(firstDayOfMonth)")
        //            print("마지막날 (한국시간): \(monthSize)")
        //            print("현재시간 (한국시간): \(formatter.string(from: Date()))")
        
        // 1. 이전달,다음달,이번달을 합쳐서 만들껄 염두에 두고 만들어보자
        // 일단은 today를 이용해서 이번달 뽑아주고 view에 그려보자 lazygrid사용
        // 오늘 날짜를 구했으면 그 날짜를 기준으로 1일이 무슨요일인지 뽑는 알고리즘
        
        
        //        let day : Int
        //        let year: Int
        //        let month: Int
        //        let isToday : Bool
        //        let isSelected : Bool
        //        let isCurrentMonth : Int
        
        //인스턴스 생성할떄 받아온 month랑 year값을 가지고 비교해야함
        
        for i in 1...monthSize {
            //            if i == isToday{
            //                CalendarDateModel(day: i,year: ,month: isToday: true, isSelected: true, isCurrentMonth: false)
            //            }else{
            //                CalendarDateModel(day: i, isToday: false, isSelected: false, isCurrentMonth: false)
            //            }
            
            dates.append(CalendarDateModel(day: i,year:2025 ,month:9, isToday: true, isSelected: true, isCurrentMonth: 9))
            
        }
        //이벤트 처리는 한쪽에 몰아서 처리할 예정이니까 그냥 day -몇일 +몇일 해서 생성하면 될듯
        
        
        
        
        return dates
        
    }
    
}
