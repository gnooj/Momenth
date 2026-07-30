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
    var isSelected : Bool
    var body: some View {
        
        RoundedRectangle(cornerRadius: 5)
            .fill(calendarDateModel.isToday ? Color.green : Color(.systemBackground))
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
//                .overlay{
//                    RoundedRectangle(cornerRadius: 5)
//                        .strokeBorder(
//                            isSelected ? Color.primary : Color.clear,
//                            style: StrokeStyle(lineWidth: 2)
//                        )
//                }
//                .animation(nil, value: isSelected)
    }
}

#Preview {
    DayCellContentView(calendarDateModel: CalendarDateModel.mock, holidays: CalendarMonthViewModel.mock.holidayName(for: CalendarDateModel.mock), dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock), isSelected: CalendarMonthViewModel.mock.isSelected(id: CalendarDateModel.mock.id))
}
