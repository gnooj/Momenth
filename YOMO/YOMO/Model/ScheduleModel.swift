//
//  CalendarScheduleModel.swift
//  YOMO
//
//  Created by 김현중 on 6/29/26.
//

import Foundation
import SwiftData


// 일정 저장에 필요한 것

// 1. 제목
// 2. 시작,종료 date 정보
// 3. 반복 여부 , 알림 여부
// 4. 메모


@Model //shcema를 활용해서 swiftdata활용을 위한 model을 만듦
final class ScheduleModel : Identifiable {
    //    @Published var title: String = ""
    //    @Published var startDate: Date
    //    @Published var endDate: Date
    //    @Published var isRepeating: Bool = false
    //    @Published var notification: Bool = false
    //    @Published var memo: String = ""



    // date() 자체로 받아서 시작종료날짜 뽑아서 저장
    var id : UUID = UUID()
    
    var title : String
    var startDate : Date
    var scheduleKey : Int{
        let c = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        return c.year! * 10000 + c.month! * 100 + c.day!
    }
    var endDate : Date
    var isRepeating : Bool?
    var notification : Bool?
    var memo : String?
    //시간도 따로 추출해서 정렬할때 써야할듯
//    var isAllDay : Bool = false

    init(title: String, startDate: Date, endDate: Date, isRepeating: Bool? = nil, notification: Bool? = nil, memo: String? = nil) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isRepeating = isRepeating
        self.notification = notification
        self.memo = memo
    }
}
