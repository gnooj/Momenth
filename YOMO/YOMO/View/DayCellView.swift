//
//  DayCellView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI
import SwiftData

struct DayCellView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    // dayCellView에서 query로 필터링해서 불러온다음에 view에 보여지는거
    // VM에서 crud 를 해주기위해서 함수를 호출한다
//    @Query private var shcedulelist : [ScheduleModel] // 필터링은 나중
    
    var calendarDateModel : CalendarDateModel
    
    
    var body: some View {
        Button {
            print("\(String(describing: calendarDateModel.id))")
            calendarMonthVM.selectDay(model: calendarDateModel)
            print("date model info = \(calendarDateModel)")
            print("\(calendarDateModel)")
            
            // overlay활용해서 테두리 넣기
            
        } label: {
            DayCellContentView(calendarDateModel: calendarDateModel, holidays: calendarMonthVM.holidayName(for: calendarDateModel), dateColor: calendarMonthVM.dateColor(for: calendarDateModel), isSelected: calendarMonthVM.isSelected(id: calendarDateModel.id))
            
            }
        .buttonStyle(.plain)

        
        }
    }



        

#Preview {
    DayCellView(calendarMonthVM: CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository()),  calendarDateModel: CalendarDateModel(pageIndex: 1200, day: 5, year: 2026, month: 7, isToday: false, isCurrentMonth: 7, type: .current, saturdaySunday: .saturday))
}
