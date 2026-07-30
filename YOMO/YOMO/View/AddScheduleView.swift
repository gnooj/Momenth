//
//  AddScheduleView.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import SwiftUI

struct AddScheduleView: View {

    @StateObject var scheduleVM : AddScheduleViewModel
    //vm에서 받아야할 변수
    var holidays : [HolidayModel]
    var dateColor : Color
    var isSelected : Bool
    //-------------------------------
    
    init(selectedDateModel: CalendarDateModel, scheduleRepo: ScheduleRepository,holidays: [HolidayModel], dateColor: Color, isSelected: Bool){
        
        _scheduleVM = StateObject(wrappedValue: AddScheduleViewModel(
            selectedDateModel: selectedDateModel,
            scheduleRepo: scheduleRepo
        ))
        self.holidays = holidays
        self.dateColor = dateColor
        self.isSelected = isSelected
    }
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                DayCellContentView(calendarDateModel: scheduleVM.selectedDateModel, holidays: holidays, dateColor: dateColor, isSelected: isSelected)
                Text("\(String(scheduleVM.selectedDateModel.year))년\(String(scheduleVM.selectedDateModel.month))월\(String(scheduleVM.selectedDateModel.day))일")
            }

                }
                
                .containerRelativeFrame(.horizontal) { length, _ in
                    length*0.7
                }
                .containerRelativeFrame(.vertical) { length, _ in
                    length*0.6
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue)
                )
                

    }
}

#Preview {
    AddScheduleView(selectedDateModel: CalendarDateModel.mock, scheduleRepo: ScheduleRepository(),holidays:CalendarMonthViewModel.mock.holidayName(for: CalendarDateModel.mock),dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock),isSelected: CalendarMonthViewModel.mock.isSelected(id: CalendarDateModel.mock.id))
}
