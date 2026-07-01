//
//  DayCellView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct DayCellView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    var calendarDateModel : CalendarDateModel
    
    var index: Int
    var istoday : Bool {
        calendarDateModel.isToday == true
    }

    var body: some View {
        Button {
            print("\(String(describing: calendarDateModel.id))")
            calendarMonthVM.selectDay(id: calendarDateModel.id)
            
            // overlay활용해서 테두리 넣기
        } label: {
                Text("\(calendarDateModel.day)")
                    
                    .frame(width: 45, height: 73, alignment: .top)
                    .font(.title3)
//                    .background(istoday ? Color(.green) : Color.clear)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(calendarDateModel.isToday ? Color.green : Color.clear)
                    }
                    .foregroundStyle(calendarDateModel.type == .current ? Color.primary : .gray.opacity(0.5))
//                    .border(calendarMonthVM.isSelected(id: calendarDateModel.id) ? Color.primary : Color.clear, width: 4)
//                    .cornerRadius(5)
                    .overlay{
                        RoundedRectangle(cornerRadius: 5)
                            
                            .strokeBorder(
                                calendarMonthVM.isSelected(id: calendarDateModel.id) ? Color.primary : Color.clear,
                                style: StrokeStyle(lineWidth: 2)
                            )
                            
                            
                    }
            }
        .buttonStyle(.plain)
        
//        .background(.gray)
        }
        
    }
        

#Preview {
    DayCellView(calendarMonthVM: CalendarMonthViewModel(),calendarDateModel: CalendarDateModel( pageIndex:1200,day: 1, year: 1, month: 1, isToday: true,isCurrentMonth: 1,type:.previous),index: 1200)
}
