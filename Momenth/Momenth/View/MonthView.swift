//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    var weeks = Array(repeating: GridItem(), count: 7)
    
    var monthSize : Int{
        return calendarMonthVM.dates.count
    }
    
//    var monthSize = 30
    
    var body: some View {
        LazyVGrid(columns: weeks){
            ForEach(1...monthSize, id: \.self){ weekday in
                DayCellView(day: weekday)
            }
        }
        .padding()
        
        
    }
}

#Preview {
    MonthView(calendarMonthVM:CalendarMonthViewModel())
}
