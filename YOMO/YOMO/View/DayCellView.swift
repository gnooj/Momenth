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
            DayCellContent(calendarDateModel: calendarDateModel, holidays: calendarMonthVM.holidayName(for: calendarDateModel), dateColor: calendarMonthVM.dateColor(for: calendarDateModel), isSelected: calendarMonthVM.isSelected(id: calendarDateModel.id))
            
            }
        .buttonStyle(.plain)

        
        }
    }

struct DayCellContent : View {
    var calendarDateModel : CalendarDateModel
    var holidays : [HolidayModel]
    var dateColor : Color
    var isSelected : Bool
    var body: some View {
        
        RoundedRectangle(cornerRadius: 5)
                .fill(calendarDateModel.isToday ? Color.green : Color.clear)
                .frame(width: 45, height: 73, alignment: .top)
                .containerShape(Rectangle())
                

                .overlay {
                    Text("\(calendarDateModel.day)")
                        .frame(width: 45, height: 73, alignment: .top)
                        .font(.title3)
//                            .foregroundStyle(calendarMonthVM.checkHoliday(key: calendarDateModel.holidayDicKey) ? .red : .primary)
                    VStack{
                        ForEach(holidays, id: \.self){ holiday in
                                Text("\(holiday.dateName)")
                                    .lineLimit(1)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.red)
                        }
                    }
                }
                .foregroundStyle(dateColor)
                .overlay{
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(
                            isSelected ? Color.primary : Color.clear,
                            style: StrokeStyle(lineWidth: 2)
                        )
                }
                .animation(nil, value: isSelected)
    }
}

        

#Preview {
    DayCellView(calendarMonthVM: CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository()),  calendarDateModel: CalendarDateModel(pageIndex: 1200, day: 5, year: 2026, month: 7, isToday: false, isCurrentMonth: 7, type: .current, saturdaySunday: .saturday))
}
