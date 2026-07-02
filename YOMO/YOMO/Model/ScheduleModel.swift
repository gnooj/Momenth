//
//  CalendarScheduleModel.swift
//  YOMO
//
//  Created by 김현중 on 6/29/26.
//

import Foundation
import SwiftData


// 일정 저장에 필요한 것
// 일정의 시작,종료 날짜
// 일정의 이름
// 반복
// 켈린더를 어디로 할지
// 알림(기본 알림, 알람으로 알림)

@Model //shcema를 활용해서 swiftdata활용을 위한 model을 만듦
final class ScheduleModel : Identifiable {
    var id : UUID = UUID()
    var title : String = ""
    var startDate : Int = 0
    var endDate : Int = 0
    var isAllDay : Bool = false

    init(title: String, startDate: Int) {
        self.title = title
        self.startDate = startDate
    }
}
