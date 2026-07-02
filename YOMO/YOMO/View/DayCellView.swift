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
    @Query private var shcedulelist : [CalendarScheduleModel] // 필터링은 나중에
    
    var calendarDateModel : CalendarDateModel
    
    
    var body: some View {
        Button {
            print("\(String(describing: calendarDateModel.id))")
            calendarMonthVM.selectDay(id: calendarDateModel.id)
            print("date model info = \(calendarDateModel)")
            print("\(calendarDateModel)")
            // overlay활용해서 테두리 넣기
            
        } label: {

            RoundedRectangle(cornerRadius: 5)
                    .fill(calendarDateModel.isToday ? Color.green : Color.clear)
                    .frame(width: 45, height: 73, alignment: .top)
                    

                    .overlay {
                        Text("\(calendarDateModel.day)")
                            .frame(width: 45, height: 73, alignment: .top)
                            .font(.title3)
//                            .foregroundStyle(calendarMonthVM.checkHoliday(key: calendarDateModel.holidayDicKey) ? .red : .primary)
                        VStack{
                            ForEach(calendarMonthVM.holidayName(for: calendarDateModel), id: \.self){ holiday in
                                    Text("\(holiday.dateName)")
                                        .lineLimit(1)
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.red)
                                        
                            }
                            
                        }
                    }
                    .foregroundStyle(calendarMonthVM.dateColor(for: calendarDateModel))
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(
                                calendarMonthVM.isSelected(id: calendarDateModel.id) ? Color.primary : Color.clear,
                                style: StrokeStyle(lineWidth: 2)
                            )
                    }
                    .animation(nil, value: calendarMonthVM.isSelected(id: calendarDateModel.id))
            }
        .buttonStyle(.plain)

        
        }
    }

        

#Preview {
    DayCellView(calendarMonthVM: CalendarMonthViewModel(),calendarDateModel: CalendarDateModel( pageIndex:1200,day: 24, year: 2026, month: 5, isToday: true,isCurrentMonth: 1,type:.previous,saturdaySunday: .sunday))
}
