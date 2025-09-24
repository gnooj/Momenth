//
//  CalendarMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/10/25.
//

import Foundation

class CalendarMonthViewModel : ObservableObject {
    
    @Published var calendarMonthModel : CalendarMonthModel//init해줘야함 아직 빈껍데기
    
    let generator = CalendarDateGenerator()
    
    init() {
        
        self.calendarMonthModel = CalendarMonthModel(year: 1, month: 1, dates: [])
        self.calendarMonthModel = generator.createMonthViewModel()
    }
    

    
}

extension CalendarMonthViewModel {
    
    // 먼저 view에서 사용할 변수종류
    // 1. 현재달
    // 2. 오늘 날짜(년,월,일)
    // 3. 달력day 배열
    // 4. 추후에 이벤트 추가 예정
    
    var currentMonth : Int {
        return calendarMonthModel.month
    }
    
    var dates : [CalendarDateModel] {
        return calendarMonthModel.dates
    }
    
}



//    private func creatCurrentMonth() -> CalendarMonthModel {
//
//        let dates = createDateModel()
//
//        return CalendarMonthModel(year: 2025, month: 9, dates:dates)
//    }
//
//    private func createDateModel() -> [CalendarDateModel] {
//        // 현재 달의 일자만 생성하는 코드
//
//
//        let currentDate = Calendar.current
//        let dates : [CalendarDateModel] = []
//
//        print(currentDate)
//
//        return dates
//    }
