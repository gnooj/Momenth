//
//  CalendarMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/10/25.
//


import Foundation
import Collections
import SwiftUI
import Combine

class CalendarMonthViewModel : ObservableObject{
    
    @Published var monthCache : [Int : [CalendarDateModel]] = [:]
    @Published var selectedDateModel : CalendarDateModel
    @Published var selectedId : Int
    @Published var currentIndex : Int = Global.CENTER_PAGE
    @Published var scheduleSheet: ScheduleEditMode?
    //전체 vm에 하나만 있는 휴일레포
    var holidayRepo : HolidayRepository
    var scheduleRepo : ScheduleRepositoryProtocol
    
    var dayOfTheWeek = Array(arrayLiteral: "일", "월", "화", "수", "목", "금", "토")
    let centerIndex: Int = Global.CENTER_PAGE
    let totalPage : Int = Global.MAX_PAGE
    var calendar = Calendar.current
    var currentYear : Int
    var currentMonth : Int
    let generator : CalendarDateGenerator
    let weeks = Array(repeating: GridItem(spacing: 0, alignment: .top), count: 7)
    var anyCancellable: Set<AnyCancellable> = []
    var visitedYearIndices = [Int](repeating: 0, count: Global.MAX_PAGE/12) // index 100 = currentMonth
    let visitedYearIndicesMid = 100
    
    init(holidayRepo: HolidayRepository, scheduleRepo: ScheduleRepositoryProtocol) {
        self.holidayRepo = holidayRepo
        self.scheduleRepo = scheduleRepo
        
        
        calendar.firstWeekday = 1
        currentYear = calendar.component(.year, from: Date())
        currentMonth = calendar.component(.month, from: Date())
        self.generator = CalendarDateGenerator()
        self.selectedId = generator.todayDateModel.id
        selectedDateModel = generator.uqdateToday()
        print("today==============\(selectedDateModel)")
        
        self.monthCache[centerIndex] = generator.createMonths(for: centerIndex)
        //        holidayRepo.setLunarHolidayDictinary()
        //        holidayRepo.setFixedHoliday(index: Global.CENTER_PAGE)
        //MARK: -  combine 파이프라인 다시 공부
        holidayRepo.objectWillChange
            .sink {[weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in:&anyCancellable)
    }
    func loadInitialHolidays(){
        holidayRepo.setLunarHolidayDictinary()
        holidayRepo.setFixedHoliday(index: Global.CENTER_PAGE)
    }
    
    func getMonthData(for index: Int){
//        Global.count = Global.count + 1
//        print("getMonthData CALL\(Global.count)")
        
        let newData = generator.createMonths(for: index)
        
        monthCache[index] = newData
        print("\(monthCache.count)")
        
    }
    
    
    
    // MARK: 일단 return에서 강제 언래핑 사용중
    
    func convertToDate(for index: Int) -> Date {
        let offset = index - centerIndex
        guard let date = calendar.date(byAdding: .month, value: offset, to: .now) else {
            return .now
        }
        return date
    }
    
    func getMonthTitle(for index: Int) -> String {
        let date = self.convertToDate(for: index)
        let title = date.toMonthKey()
        return  title
    }
    
    func selectDay (model: CalendarDateModel){
        if selectedId == model.id {
//            showingSheet = true
            print("같을때\(model.holidayDicKey)")
            // 나중에 여길 아무타입이나와도 되는걸로 바꾸자
            scheduleSheet = .create(date: model)
        }else {
            selectedId = model.id
            selectedDateModel = model
            print("다를떄\(model.holidayDicKey)")
        }
        
    }
    func editSchedule(model: ScheduleModel) {
        scheduleSheet = .edit(model)
    }
    
    // view에서 선택된 날짜 하이라이트 기능에서 쓰임
    func isSelected(id: Int) -> Bool {
        id == selectedId
    }
    
    func toYearMonth(from index: Int) -> Int {
        let offset = index - centerIndex
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMM"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        guard let targetMonth = Calendar.current.date(byAdding: .month, value: offset, to: Date()),
              let result = Int(formatter.string(from: targetMonth)) else { return 0 }
        //            print("index : \(index), result: \(result)")
        
        return result
        
    }
    
    //    func loadMonthGridViewData (index : Int){
    //        monthGridViewDataUpdate(index: index)
    //    }
    func monthGridViewDataUpdate(index: Int) {
        
        guard monthCache[index] == nil else { return }
        //        monthGridViewData = getMonthData(for: index)
        getMonthData(for: index)
        
    }
    // 휴일과 일정을 같이 합쳐줄 코드 필요함 나중에는 특정 태그만 보고싶을때 필터링 할 수 있도록 하는 코드가 있어야하기 때문에 합쳐지는 쪽에서 태그보고 태그나오도록 만들어야함
    func holidays(for model: CalendarDateModel) -> [HolidayModel] {
        let holidays = holidayRepo.holidaysDictionary[model.holidayDicKey] ?? []

        return holidays
    }
    
    func schedules(for model: CalendarDateModel) -> [ScheduleModel] {
        //지금 daycell 누를때마다 엄청많이 호출됨
        scheduleRepo.schedules(on: model.holidayDicKey)

//        schedulesByDay[model.holidayDicKey] ?? []
    }
    
    func dateColor(for model: CalendarDateModel) -> Color {
        let baseColor: Color
        switch model.saturdaySunday {
        case .sunday:
            baseColor = .red
        case .saturday:
            baseColor = .blue
        case .weekdays:
            baseColor = .primary   // 평일은 기본색
        }
        return checkHoliday(key: model.holidayDicKey) ? .red : baseColor
    }
    
    func checkHoliday(key : Int) -> Bool {
        if holidayRepo.holidaysDictionary[key] != nil {
            return true
        }
        return false
    }
    
    
}
