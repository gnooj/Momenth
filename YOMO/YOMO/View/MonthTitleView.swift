//
//  MonthTitleView.swift
//  Momenth
//
//  Created by 김현중 on 10/23/25.
//

import SwiftUI

struct MonthTitleView: View {
    
    @ObservedObject var calendarVM: CalendarMonthViewModel
    
    var index : Int
    
    
    var body: some View {
        HStack(alignment: .top) {
            
            Text("\(calendarVM.getMonthTitle(for: index))")
                .font(.largeTitle.bold())
                .padding(.leading, 30)
            Spacer()
        }
    }
}

#Preview {
    MonthTitleView(calendarVM : CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo:MockScheduleRepository.mock), index: 1199)
}
