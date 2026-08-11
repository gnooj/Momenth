//
//  AddSchedule.swift
//  YOMO
//
//  Created by 김현중 on 7/1/26.
//

import Foundation


enum ScheduleEditMode : Identifiable{
    case create(date: CalendarDateModel)
    case edit(ScheduleModel)
    var id: String {
            switch self {
            case .create(let d): "create-\(d.year)-\(d.month)-\(d.day)"
            case .edit(let s):   "edit-\(s.id)"
            }
        }
}
extension CalendarDateModel {
        init(date: Date){
        let calendar = Calendar.current
        let c = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let weekday = calendar.component(.weekday, from: date)
        var weekdayType: CalendarDateModel.SaturdaySunday = .weekdays
        if weekday == 1 {
            weekdayType = .sunday
        }else if weekday == 7 {
            weekdayType = .saturday
        }
        self.init(pageIndex: 0, day: c.day ?? 0, year: c.year ?? 0 , month: c.month ?? 0, isToday: calendar.isDateInToday(date), isCurrentMonth: 0, type: .current, saturdaySunday: weekdayType)
    }
}
extension ScheduleEditMode {
    var dateModel: CalendarDateModel {
        switch self {
        case .create(let date): date
        case .edit(let schedule):
            CalendarDateModel(date: schedule.startDate)
        }
    }
}
// 일단 asvm 에서 보여줄건 클린된 날짜 정보
// View 에서 id 보내주면 그거 받아서 처리할 함수
//
class AddScheduleViewModel: ObservableObject {
    let cal = Calendar.current
    @Published var title: String = ""
    @Published var startDate: Date {
        didSet {
            endDate = Self.hourOnTheHour(date: startDate, addingHour: 1, minute: cal.component(.minute, from: startDate))
            if endDate < startDate {
                endDate = Self.hourOnTheHour(date: startDate, addingHour: 1)
            }
        }
    }
    @Published var endDate: Date
    @Published var isRepeating: Bool = false
    @Published var notification: Bool = false
    @Published var memo: String = ""
    
    
    let mode : ScheduleEditMode
//    let selectedDateModel : CalendarDateModel
    private let scheduleRepo : ScheduleRepositoryProtocol
    
//    let hour : Date
    
    init(scheduleRepo: ScheduleRepositoryProtocol, mode : ScheduleEditMode) {
        self.scheduleRepo = scheduleRepo
        
        
        self.mode = mode
        
        switch mode {
        case .create(let date):
            let cal = Calendar.current
            var c = DateComponents()
            c = cal.dateComponents([.hour, .minute], from: Date())
            c.year = date.year
            c.month = date.month
            c.day = date.day
            let current = cal.date(from: c)
            self.startDate = Self.hourOnTheHour(date : current ?? Date())
            self.endDate = Self.hourOnTheHour(date: current  ?? Date(), addingHour: 1)
            
        case .edit(let schedule):
            title = schedule.title
            startDate = schedule.startDate
            endDate = schedule.endDate
            isRepeating = schedule.isRepeating ?? false
            notification = schedule.notification ?? false
            memo = schedule.memo ?? ""
            
        }
    }
    // 만약에 여러날짜에 걸쳐있는 일정이 들어오면 일자마다 일정을 다 추가해주는 코드를 만들어야함 vm에서는 데이터를 합치기만하고 일자를 실제로 등록할때는 repo에서 하게끔 만들기
    //startdate가 변경되면 enddate도 바꿔주고 enddate에서는 따로 설정 x 하는 코드
    func complete (){
        guard !title.isEmpty else { return }// 제목이 비어있으면 채우라고 말하는 코드 필요
        switch mode {
        case .create:
            
            try? scheduleRepo.insert(ScheduleModel(title: title, startDate: startDate, endDate: endDate, isRepeating: isRepeating, notification: notification ,memo: memo))
        case .edit(let schedule):
            schedule.title = title
            schedule.startDate = startDate
            schedule.endDate = endDate
            schedule.isRepeating = isRepeating
            schedule.notification = notification
            schedule.memo = memo
            scheduleRepo.save()
        }
        
        print("complete start date == \(startDate)")
        
        
    }

    private static func hourOnTheHour(date : Date, addingHour value : Int = 0, minute : Int = 0) -> Date {
        let current = Calendar.current
        
        var c = current.dateComponents([.year,.month,.day, .hour], from: date)
        c.minute = minute
        let base = current.date(from: c) ?? date
        
        
        
        return current.date(byAdding: .hour, value: value, to: base) ?? base
    }

}
