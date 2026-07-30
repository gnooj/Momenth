//
//  AddSchedule.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import Foundation
// 일단 asvm 에서 보여줄건 클린된 날짜 정보
// View 에서 id 보내주면 그거 받아서 처리할 함수
//
class AddScheduleViewModel: ObservableObject {
    let selectedDateModel : CalendarDateModel
    private let scheduleRepo : ScheduleRepository
    
    init(selectedDateModel: CalendarDateModel, scheduleRepo: ScheduleRepository) {
        self.selectedDateModel = selectedDateModel
        self.scheduleRepo = scheduleRepo
    }
    

}
