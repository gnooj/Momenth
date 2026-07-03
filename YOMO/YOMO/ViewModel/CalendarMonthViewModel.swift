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
    @Published var selectedId : Int
    @Published var currentIndex : Int = Global.CENTER_PAGE
    @Published var addScheduleTrigger = false
    //전체 vm에 하나만 있는 휴일레포
    var holidayRepo : HolidayRepository
    var scheduleRepo : ScheduleRepository
    
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

    init(holidayRepo: HolidayRepository, scheduleRepo: ScheduleRepository) {
        self.holidayRepo = holidayRepo
        self.scheduleRepo = scheduleRepo


        calendar.firstWeekday = 1
        currentYear = calendar.component(.year, from: Date())
        currentMonth = calendar.component(.month, from: Date())
        self.generator = CalendarDateGenerator()
        selectedId = generator.uqdateToday()
        print("today==============\(selectedId)")
        
        self.monthCache[centerIndex] = generator.createMonths(for: centerIndex)
        holidayRepo.setLunarHolidayDictinary()
        holidayRepo.setFixedHoliday(index: Global.CENTER_PAGE)
    }
    
    func getMonthData(for index: Int){
        Global.count = Global.count + 1
        print("getMonthData CALL\(Global.count)")
        
        let newData = generator.createMonths(for: index)
        
        monthCache[index] = newData
        print("\(monthCache.count)")
        
    }
    
    func monthGridViewDataUpdate(index: Int) {
        Global.count = Global.count + 1
        print("monthGridViewDataUpdate CALL\(Global.count)")
        //        monthGridViewData = getMonthData(for: index)
        getMonthData(for: index)
        
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
    
    func selectDay (id: Int){
        if selectedId == id {
            addScheduleTrigger = true
        }else {
            selectedId = id
        }
        
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
    
    func loadMonthGridViewData (index : Int){
        monthGridViewDataUpdate(index: index)
    }
    func holidayName(for model: CalendarDateModel) -> [HolidayModel] {
        holidayRepo.holidaysDictionary[model.holidayDicKey] ?? []
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
