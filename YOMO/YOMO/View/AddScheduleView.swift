//
//  AddScheduleView.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import SwiftUI

struct AddScheduleView: View {
    
    @StateObject var scheduleVM : AddScheduleViewModel
    @Binding var addScheduleTrigger: Bool
    //vm에서 받아야할 변수
    var holidays : [HolidayModel]
    var dateColor : Color
    var schedules: [ScheduleModel]
    

    
    init(selectedDateModel: CalendarDateModel, scheduleRepo: ScheduleRepositoryProtocol,addScheduleTrigger:Binding<Bool>,holidays: [HolidayModel], dateColor: Color,  schedules: [ScheduleModel]){
        
        _scheduleVM = StateObject(wrappedValue: AddScheduleViewModel(
            selectedDateModel: selectedDateModel,
            scheduleRepo: scheduleRepo
        ))
        self.holidays = holidays
        self.dateColor = dateColor
        self.schedules = schedules
        _addScheduleTrigger = addScheduleTrigger
    }
    
    var body: some View {
        VStack(alignment: .leading){

            HStack(){
                DayCellContentView(calendarDateModel: scheduleVM.selectedDateModel, holidays: holidays, dateColor: dateColor,schedules: schedules)
                
                Text("\(String(scheduleVM.selectedDateModel.year))년\(String(scheduleVM.selectedDateModel.month))월\(String(scheduleVM.selectedDateModel.day))일")
                Button {
                    scheduleVM.complete()
                    addScheduleTrigger = false
                } label: {
                    Text("완료")
                        .foregroundStyle(Color.black)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.red)
                        )
                }
            }
            .padding(10)
            
            Form{
                HStack{
                    TextField("제목", text: $scheduleVM.title)
                }
                HStack{
                    
                    DatePicker("시작", selection: $scheduleVM.startDate, displayedComponents: [.date, .hourAndMinute])
                }
                HStack{
                    
                    DatePicker("종료", selection: $scheduleVM.endDate, displayedComponents: [.date, .hourAndMinute])
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
    }
}

#Preview {
    AddScheduleView(selectedDateModel: CalendarDateModel.mock, scheduleRepo: MockScheduleRepository(schedules: []),addScheduleTrigger: .constant(true), holidays:CalendarMonthViewModel.mock.holidays(for: CalendarDateModel.mock),dateColor: CalendarMonthViewModel.mock.dateColor(for: CalendarDateModel.mock),schedules: CalendarMonthViewModel.mock.schedules(for :CalendarDateModel.mock))
}
