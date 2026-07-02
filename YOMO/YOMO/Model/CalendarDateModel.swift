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
    enum SaturdaySunday {
        case saturday
        case sunday
        case weekdays
    }
    
//    let id : Int
    var id: Int {
        pageIndex * 10000000 + year * 10000 + month * 100 + day  // index년월일 = 1220250101
    }
    //holidayDicKey 를 여기서 관리하는게 맞는지 생각해보기
    var holidayDicKey : Int{
        (((year*100)+month)*100)+day
    }
    let pageIndex : Int
    let day : Int
    let year : Int
    let month: Int
    let isToday : Bool
//    var isSelected : Bool
    let isCurrentMonth : Int
    let type : DayType
    var saturdaySunday : SaturdaySunday
    
    /**
     let holyday : Bool
    let holydayName : String
     
     **/
}
