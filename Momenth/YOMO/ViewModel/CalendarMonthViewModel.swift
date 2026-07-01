//
//  CalendarMonthViewModel.swift
//  Momenth
//
//  Created by 김현중 on 9/10/25.
//


import Foundation
import Collections
import SwiftUI

class CalendarMonthViewModel : ObservableObject{
    
//    @Published var isSelected: Bool = false
    @Published var monthCache : [Int : [CalendarDateModel]] = [:]
    @Published var selectedId : Int? = nil
    
    var lastIndex : Int = Global.CENTER_PAGE
    let centerIndex: Int = Global.CENTER_PAGE
    let totalPage : Int = Global.MAX_PAGE
    var calendar = Calendar.current
    let generator : CalendarDateGenerator
    let weeks = Array(repeating: GridItem(spacing: 0, alignment: .top), count: 7)
    
//    var dump : [CalendarMonthModel]
    
    
    init() {
//        self.dump = []
        calendar.firstWeekday = 1
        self.generator = CalendarDateGenerator()
        for offset in -1...1 {
            let targetIdx = centerIndex + offset
//            self.dump.append(generator.createMonths(for: targetIdx))
            self.monthCache[targetIdx] = generator.createMonths(for: targetIdx)
        }
    }
    
    func onPageChanged(to index: Int) {

//        let direction = index - lastIndex
        
//        if direction > 0 {
//            // 앞으로 갈 때: 다음 1개 미리 로드
//            _ = getMonthData(for: index+2)
//        } else if direction < 0 {
//            // 뒤로 갈 때: 이전 1개 미리 로드
//            _ = getMonthData(for: index-2)
//        }
        lastIndex = index
    }
    
    func getMonthData(for index: Int) -> [CalendarDateModel] {
        
        if let cachedData = self.monthCache[index] {
            return cachedData
        }

        let newData = generator.createMonths(for: index)

        monthCache[index] = newData
        return newData
    }
    
//    func getPrevMonthDate(for index : Int, offset : Int) -> CalendarDateModel {
//        //달의 총 일 수로 마지막날 뽑기
//        
////        let numberOfDays = calendar.range(of: .day, in: .month, for: date)!.count
//        
////        return getMonthData(for: lastIndex-1).dates.first!
//    }
    

    
    
    // MARK: 일단 return에서 강제 언래핑 사용중

    func convertToDate(for index: Int) -> Date {
        let offset = index - centerIndex
        return calendar.date(byAdding: .month, value: offset, to: .now)!
    }
    
    func getMonthTitle(for index: Int) -> String {
        let date = self.convertToDate(for: index)
        let title = date.toMonthKey()
        return  title
    }
    
    func selectDay (id: Int) -> Void {
        selectedId = id
 
    }
    func isSelected(id: Int) -> Bool {
        id == selectedId
    }
}
