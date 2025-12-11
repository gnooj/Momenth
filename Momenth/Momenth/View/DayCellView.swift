//
//  DayCellView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct DayCellView: View {
    
    let calendarDateModel : CalendarDateModel
    var day: Int
    var index: Int
    var istoday : Bool {
        calendarDateModel.isToday == true
    }

    
    var body: some View {
        Button {
            print("\(String(describing: calendarDateModel))")
        } label: {

                Text("\(calendarDateModel.day)")
                    .frame(width: 45, height: 73, alignment: .top)
                    .font(.title3)
                    .background(istoday ? Color(.red) : Color.clear)
                    .cornerRadius(5)
                    .foregroundStyle(calendarDateModel.type == .current ? Color.primary : .gray)
            }
        .buttonStyle(.plain)
        }
        
    }
        

#Preview {
    DayCellView(calendarDateModel: CalendarDateModel(id: 1, day: 1, year: 1, month: 1, isToday: true, isSelected: true, isCurrentMonth: 1,type:.previous),day: 1, index: 1200)
}
