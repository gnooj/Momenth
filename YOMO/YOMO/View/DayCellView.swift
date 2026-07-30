//
//  DayCellView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI
import SwiftData

struct DayCellView: View {
    // 여기 vm을 각 셀마다 구독하는게 아니라 상위 계층에서 값만 내려보내는 걸로 바꿔야함
    @Binding var showingSheet: Bool
    let calendarMonthVM : CalendarMonthViewModel
    
//    calendarDateModel: calendarDateModel
    var calendarDateModel : CalendarDateModel
    var holidays: [HolidayModel]
    var dateColor: Color
    var schedules: [ScheduleModel]
    
    
    
    var body: some View {
        Button {
//            calendarMonthVM.showingSheet.toggle()
            calendarMonthVM.selectDay(model: calendarDateModel)
            
            
            // overlay활용해서 테두리 넣기
            
        } label: {
            DayCellContentView(calendarDateModel: calendarDateModel, holidays: holidays, dateColor: dateColor, schedules: schedules)
            
            }
        .buttonStyle(.plain)

        
        }
    }



        

#Preview {
    DayCellView(showingSheet: .constant(true),calendarMonthVM: CalendarMonthViewModel.mock,  calendarDateModel: CalendarDateModel(pageIndex: 1200, day: 5, year: 2026, month: 7, isToday: false, isCurrentMonth: 7, type: .current, saturdaySunday: .saturday),holidays: CalendarMonthViewModel.mock.holidays(for: CalendarDateModel.mock),dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock),schedules: CalendarMonthViewModel.mock.schedules(for :CalendarDateModel.mock))
}
