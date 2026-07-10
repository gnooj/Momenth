//
//  AddScheduleView.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import SwiftUI

struct AddScheduleView: View {

    @StateObject var scheduleVM : AddScheduleViewModel
    
    
    init(selectedDateModel: CalendarDateModel, addScheduleRepo: ScheduleRepository){
        _scheduleVM = StateObject(wrappedValue: AddScheduleViewModel(
            selectedDateModel: selectedDateModel,
            addScheduleRepo: addScheduleRepo
        ))
    }
    var body: some View {
                VStack{
                    // 이 값들 monthview에서 내려받을 값들임
//                    DayCellContent(calendarDateModel: <#T##CalendarDateModel#>, holidays: <#T##[HolidayModel]#>, dateColor: <#T##Color#>, isSelected: <#T##Bool#>)
                }

    }
}

#Preview {
    AddScheduleView(selectedDateModel: CalendarDateModel.mock, addScheduleRepo: ScheduleRepository())
}
