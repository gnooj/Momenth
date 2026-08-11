//
//  AddScheduleView.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import SwiftUI

struct AddScheduleView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var scheduleVM : AddScheduleViewModel

    //vm에서 받아야할 변수
    var holidays : [HolidayModel]
    var dateColor : Color
    var schedules: [ScheduleModel]
    let mode : ScheduleEditMode

    
    init(scheduleRepo: ScheduleRepositoryProtocol,holidays: [HolidayModel], dateColor: Color,  schedules: [ScheduleModel], mode : ScheduleEditMode){
        
        _scheduleVM = StateObject(wrappedValue: AddScheduleViewModel(
            scheduleRepo: scheduleRepo, mode: mode
        ))
        self.holidays = holidays
        self.dateColor = dateColor
        self.schedules = schedules
        self.mode = mode
    }
    
    var body: some View {
        VStack(alignment: .leading){

            HStack(){
                DayCellContentView(calendarDateModel: mode.dateModel, holidays: holidays, dateColor: dateColor,schedules: schedules)
                
                Text("\(String(mode.dateModel.year))년\(String(mode.dateModel.month))월\(String(mode.dateModel.day))일")
                Spacer()
                Button {
                    scheduleVM.complete()
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                        .bold()
                        .background(
                            Circle()
                                .fill(.green)
                        )
                }
                
            }
            .padding(20)
            
            Form{
                HStack{
                    TextField("제목", text: $scheduleVM.title)
                }
                HStack{
                    
                    DatePicker("시작", selection: $scheduleVM.startDate, displayedComponents: [.date, .hourAndMinute])
                }
                HStack{
                    
                    DatePicker("종료", selection: $scheduleVM.endDate,in: scheduleVM.startDate..., displayedComponents: [.date, .hourAndMinute])
                }
                HStack{
                    Toggle("반복", isOn: $scheduleVM.isRepeating)
                }
                
                HStack{
                    Toggle("알림", isOn: $scheduleVM.notification)
                }
                HStack{
                    TextField("메모", text: $scheduleVM.memo)
                }
            }// Form END
            .scrollContentBackground(.hidden)

        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.gray))
        )
        .ignoresSafeArea()
    }
}

#Preview {
    AddScheduleView(
        scheduleRepo: MockScheduleRepository(schedules: []),
        holidays:CalendarMonthViewModel.mock.holidays(for: CalendarDateModel.mock),
        dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock),
        schedules: CalendarMonthViewModel.mock.schedules(for :CalendarDateModel.mock),
        mode: .create(date: CalendarDateModel.mock)
    )
}
