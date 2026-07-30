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
    @Published var title: String = ""
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isRepeating: Bool = false
    @Published var notification: Bool = false
    @Published var memo: String = ""
    
    let selectedDateModel : CalendarDateModel
    private let scheduleRepo : ScheduleRepositoryProtocol
    
//    let hour : Date
    
    init(selectedDateModel: CalendarDateModel, scheduleRepo: ScheduleRepositoryProtocol) {
        self.selectedDateModel = selectedDateModel
        self.scheduleRepo = scheduleRepo
        self.startDate = Self.hourOnTheHour(model : selectedDateModel)
        self.endDate = Self.hourOnTheHour(model: selectedDateModel, addingHour: 1)
//        self.hour = AddScheduleViewModel.currentHour()
    }
    func complete (){
        print("complete start date == \(startDate)")
        try? scheduleRepo.insert(ScheduleModel(title: title, startDate: startDate, endDate: endDate, isRepeating: isRepeating, notification: notification ,memo: memo))
        
//      ScheduleModel(title: <#T##String#>, startDate: <#T##Int#>, endDate: <#T##Int#>)
    }
//    private static func hourOnTheHosur() -> Date {
//        let current = Calendar.current
//        let hour = current.component(.hour, from: Date())
////        let comps = result.dateComponents([.year, .month, .day, .hour], from: Date())
//        return current.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) ?? Date()
////        return Date()
//    }
    private static func hourOnTheHour(model : CalendarDateModel, addingHour value : Int = 0) -> Date {
        let current = Calendar.current
        var c = DateComponents()
        c.year = model.year
        c.month = model.month
        c.day = model.day
        c.hour = current.component(.hour, from:Date()) + value
        c.minute = 0
        
        return current.date(from: c) ?? Date()
    }
    // 내가 보내야할 데이터
    // 1. 제목
    // 2. 시작,종료 date 정보
    // 3. 반복 여부 , 알림 여부
    // 4. 메모
    /*
     @State var title: String = ""
     @State var memo: String = ""
     @State var notification: Bool = false
     @State var isRepeating: Bool = false
     @State var startDate: Date = Date()
     @State var endDate: Date = Date()
     @Binding var addScheduleTrigger: Bool

     하나씩 받아서 배열에 넣고 그 배열을 vm에 전달 -> vm에서 꺼내서 model에 저장해서 스케쥴 레포로 넘김 -> 여기서
     var year : Int = 0
     var month : Int = 0
     var day : Int = 0
     var id : UUID = UUID()
     var title : String = ""
     var startDate : Int = 0
     var endDate : Int = 0
     var notification : Bool = false
     var isRepeat : Bool = false
     var memo : String = ""
     */
}
