//
//  CalendarDateModel.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import Foundation

struct CalendarDateModel : Identifiable, Hashable{
    
//    let date : Date
    let id : Int
    let day : Int
    let year : Int
    let month: Int
    let isToday : Bool
    let isSelected : Bool
    let isCurrentMonth : Int
    
    
}
