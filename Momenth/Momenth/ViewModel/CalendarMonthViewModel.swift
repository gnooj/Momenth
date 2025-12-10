//
//  CalendarMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/10/25.
//


import Foundation
import Collections

class CalendarMonthViewModel : ObservableObject{
    
    //    @Published var currentDate : Date?
    @Published var currentMonthKey : String = ""
//    @Published var months : [String : CalendarMonthModel]
    
    @Published var monthCache : [Int : CalendarMonthModel] = [:]
    
//    @Published var monthKeys : Deque<String>
    var lastIndex : Int = Global.CENTER_PAGE
    
    let centerIdx = Global.CENTER_PAGE
    let totalPage = Global.MAX_PAGE
    
    //    @Published private(set) var lastMonthKey : String = ""
    //    @Published private(set) var firstMonthKey : String = ""
    var calendar = Calendar.current
    var formatter = DateFormatter()
    let generator : CalendarDateGenerator
    
    
    
    init() {
//        self.months = [:]
        self.formatter.dateFormat = "yyyy-MM"
//        self.monthKeys = []
        self.generator = CalendarDateGenerator()
        
        for offset in -1...1 {
            let targetIdx = centerIdx + offset
//            if let data  = calendar.date(byAdding: .month, value: offset, to: .now) {
               
                self.monthCache[targetIdx] = generator.createMonths(for: targetIdx)
//            }
        }
        
//        monthKeys = Deque(months.keys.sorted())
//        
//        print(months.keys)
//        currentMonthKey = monthKeys[1]
        //        self.lastMonthKey = monthKeys[2]
        //        self.firstMonthKey = monthKeys[0]
        
    }
    
    func onPageChanged(to index: Int) {
        let direction = index - lastIndex
        
        if direction > 0 {
            // 앞으로 갈 때: 다음 2개 미리 로드
            getNextMonth(for: index + 1)
            
        } else if direction < 0 {
            // 뒤로 갈 때: 이전 2개 미리 로드
            getNextMonth(for: index - 1)
            
        }
        
        lastIndex = index
    }
    
    func getNextMonth(for index: Int) -> Void {
        
        if let _ = self.monthCache[index] {
            return
        }
       
        self.monthCache[index] = generator.createMonths(for: index)
//        let dateParts = monthKey.split(separator: "-")
        
////        guard let year = Int(dateParts[0]),
////              let month = Int(dateParts[1]),
////              let baseDate = calendar.date(from: DateComponents(year: year, month: month)),
////              let newDate = calendar.date(byAdding: .month, value: offset, to: baseDate)
////        else { return }
//        
////        let newKey = newDate.toMonthKey()
//        self.months[newKey] = generator.createMonths(date:  newDate)
//        
//        if offset > 0 {
//            self.monthKeys.append(newKey)
//            //            self.lastMonthKey = newKey
//        }else {
//            self.monthKeys.prepend(newKey)
//            //            self.firstMonthKey = newKey
//        }
//        print("vm monthkeys == \(monthKeys)")
//        print("dkdkjdkfjdkfj")
//        
        //        return Date()
        
        
        
    }
    
    
    // MARK: 일단 return에서 강제 언래핑 사용중

    func convartToDate(for index: Int) -> Date {
        
        let offset = index - centerIdx
        
        return calendar.date(byAdding: .month, value: offset, to: .now)!
    }
    
    func getCurrentMonthFirstDayOfWeek() -> Void {
        
        
        
        
        //        let result = months[key]?.dates.count ?? 0
        ////        print("key == \(key)")
        ////        print("reslut == \(result)")
        
    }
    
    
    
    
    
}

//extension CalendarMonthViewModel {
//    
//    var fullCalendar : [CalendarDateModel] {
//        
//        var fullMonthDates : [CalendarDateModel] = []
//        
//        guard let idx = monthKeys.firstIndex(where: { $0 == currentMonthKey}) else { return [] }
//        let currentIdx  = monthKeys.distance(from: monthKeys.startIndex, to: idx)
//        let curMonthKey = monthKeys[currentIdx]
//        let prevMonthKey = monthKeys[currentIdx - 1]
//        let nextMonthKey = monthKeys[currentIdx + 1]
//        let dateParts = curMonthKey.split(separator:"-")
//        
//        // MARK:  ------- 이부부분 nextmonth()에서 중복 중
//        var components = DateComponents()
//        components.year = Int(dateParts[0])
//        components.month = Int(dateParts[1])
//        guard let date = calendar.date(from: components) else { return [] }
//        
//        let firstDayOfWeek = calendar.component(.weekday, from: date)
//        let prevMonthSize = months[prevMonthKey]?.dates.endIndex
//        
//        if let prevMonthSize = prevMonthSize {
//            for i in prevMonthSize-(firstDayOfWeek-1) ..< prevMonthSize {
//                fullMonthDates.append(months[prevMonthKey]?.dates[i] ??
//                                      CalendarDateModel(id:1, day: 1, year: 1, month: 1, isToday:true, isSelected: true, isCurrentMonth: 1))
//            }
//            for i in 0..<(months[curMonthKey]?.dates.count ?? 0) {
//                fullMonthDates.append(months[curMonthKey]?.dates[i] ??
//                                      CalendarDateModel(id:1, day: 1, year: 1, month: 1, isToday:true, isSelected: true, isCurrentMonth: 1))
//            }
//            if ((months[curMonthKey]?.dates.count ?? 0)+firstDayOfWeek-1)%7 != 0 {
//                for i in 0..<7-(((months[curMonthKey]?.dates.count ?? 0)+firstDayOfWeek-1)%7){
//                    fullMonthDates.append(months[nextMonthKey]?.dates[i] ??
//                                          CalendarDateModel(id:1, day: 1, year: 1, month: 1, isToday:true, isSelected: true, isCurrentMonth: 1))
//                }
//            }
//            
//        }
//        
//        
//        
//        
//        //        for i in .0 {
//        
//        
//        
//        return fullMonthDates
//        
//    }
//    
//    
//}
