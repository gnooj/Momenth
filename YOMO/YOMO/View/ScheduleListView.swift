//
//  ScheduleListView.swift
//  YOMO
//
//  Created by 김현중 on 8/10/26.
//

import SwiftUI

struct ScheduleListView: View {
//    @Binding var mode : ScheduleEditMode?
    let holidays : [HolidayModel]
    let schedules : [ScheduleModel]
    let selectedDateModel : CalendarDateModel
    var onSelectSchedule : (ScheduleModel) -> Void
//    let scheduleRepo : ScheduleRepositoryProtocol
    
    var body: some View {
        VStack{
            HStack{
                Text("\(selectedDateModel.month)월 \(selectedDateModel.day)일")
                Spacer()
                ForEach(holidays, id: \.self) { holiday in
                    Text("\(holiday.dateName)")
                }
                
            }
            .font(.title)
            if schedules.isEmpty {
                Text("일정이 없습니다")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
            }else {
                ForEach(schedules, id: \.self) { schedule in
                    
                    Button {
                        onSelectSchedule(schedule)
                    } label: {
                        HStack{
                            Text("\(schedule.title)")
                            Spacer()
                            VStack{
                                Text("시작 : \(schedule.startDate, format:.dateTime.hour().minute())")
                                Text("종료 : \(schedule.endDate, format:.dateTime.hour().minute())")
                                //선택된 일자가 오늘로 부터 -+ 며칠!
                            }
                        }
                        .padding(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.gray, lineWidth: 1.5)
                    )
                    
                    .buttonStyle(.plain)
                }//ForEach
            }
            
        }//VStack
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ScheduleListView(
//        mode: .constant(.edit(ScheduleModel.mock)),
        holidays: CalendarMonthViewModel.mock.holidays(for: CalendarMonthViewModel.mock.selectedDateModel),
        schedules: CalendarMonthViewModel.mock.schedules(for: CalendarMonthViewModel.mock.selectedDateModel),
        selectedDateModel: CalendarMonthViewModel.mock.selectedDateModel)  { print("탭:", $0.title) }
}
#Preview("빈 상태") {
    ScheduleListView(holidays: [], schedules: [], selectedDateModel: .mock) { _ in }
        .border(.red)
}
