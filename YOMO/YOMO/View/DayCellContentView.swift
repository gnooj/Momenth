//
//  DayCellContentView.swift
//  YOMO
//
//  Created by 김현중 on 7/10/26.
//

import SwiftUI

struct DayCellContentView : View {
    var calendarDateModel : CalendarDateModel
    var holidays : [HolidayModel]
    var dateColor : Color
    var schedules : [ScheduleModel]
    var body: some View {
        VStack{
            Text("\(calendarDateModel.day)")
                .font(.subheadline)
            ForEach(holidays, id: \.self){ holiday in
                    Text("\(holiday.dateName)")
                        .lineLimit(1)
                        .font(.system(size: 9))
                        .fontWeight(.semibold)
                        .foregroundStyle(.red)
            }
            ForEach(schedules, id: \.id){ schedule in
                    Text("\(schedule.title)")
                        .lineLimit(1)
                        .font(.system(size: 9))
                        .fontWeight(.semibold)
                        .foregroundStyle(.cyan)
            }
            
        }
//        .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(calendarDateModel.isToday ? Color.green : Color(.systemBackground))
                )
                .contentShape(Rectangle())
                .foregroundStyle(dateColor)
//        RoundedRectangle(cornerRadius: 5)
//            .fill(calendarDateModel.isToday ? Color.green : Color(.systemBackground))
////                .frame(width: 50, height: 77, alignment: .top)
//                .contentShape(Rectangle())
//                
//
//                .overlay {
//                    
////                    .frame(width: 45, height: 73, alignment: .top)
//                    
//                }
//                .foregroundStyle(dateColor)

    }
}

#Preview {
    DayCellContentView(
        calendarDateModel: .mock,
        holidays: [HolidayModel(id: UUID(), dateName: "광복절", year: 2026, month: 8, day: 15)],
        dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock),
        schedules: CalendarMonthViewModel.mock.schedules(for :CalendarDateModel.mock)
    )
}
