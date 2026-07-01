//
//  CalendarDateModel.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import Foundation

struct CalendarDateModel : Identifiable, Hashable{
    
    enum DayType {
            case previous   // 이전 달
            case current    // 이번 달
            case next       // 다음 달
        }
    
//    let id : Int
    var id: Int {
        pageIndex * 10000000 + year * 10000 + month * 100 + day  // 20250115
    }
    let pageIndex : Int
    let day : Int
    let year : Int
    let month: Int
    let isToday : Bool
//    var isSelected : Bool
    let isCurrentMonth : Int
    let type : DayType
}
