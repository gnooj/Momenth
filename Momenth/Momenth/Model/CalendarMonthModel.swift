//
//  CalendarMonthModel.swift
//  Momenth
//
//  Created by 김현중 on 9/10/25.
//

import Foundation

struct CalendarMonthModel : Identifiable{
    let id : Int
    let year: Int
    let month: Int
    let dates : [CalendarDateModel]

    
    var monthName : String {
        return "\(month) 월"
    }
    
}
