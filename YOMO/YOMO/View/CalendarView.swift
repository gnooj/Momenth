//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    @State private var scrollID: Int? = Global.CENTER_PAGE
//    @State private var showingSheet: Bool = false
    var body: some View {
        ScrollView {
            VStack(){
                VStack{
                    
                    MonthTitleView(calendarVM: calendarMonthVM, index: calendarMonthVM.currentIndex)
                        .background(.red)
                    
                    VStack {
                        LazyVGrid(columns: calendarMonthVM.weeks, spacing: 0){
                            ForEach(calendarMonthVM.dayOfTheWeek, id: \.self){ week in
                                Text("\(week)")
                                    .font(.caption)
                            }
                            .frame(width: 360)
    //                        .background(.blue)
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    ScrollView(.horizontal){
                        LazyHStack(alignment:.top,spacing: 0){//lazy로 했을때 문제 생각해보기
                            ForEach(0...calendarMonthVM.totalPage, id: \.self){ index in
                                MonthGridView(calendarMonthVM: calendarMonthVM, index: index)
                                    .containerRelativeFrame(.horizontal)
    //                                .containerRelativeFrame(.vertical)
    //                                .frame(maxWidth: /*500*/)
                                    .id(index)
                                    .background(.green)
                            }//ForEach
                            
                        }//LazyHStack
                        .scrollTargetLayout()
                        
                    }// ScrollView
                    .frame(height: 530)
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $scrollID)
                    .onChange(of: scrollID) { _, newValue in
                        if let v = newValue, v != calendarMonthVM.currentIndex {
                            calendarMonthVM.currentIndex = v
                        }
                    }
                    .onChange(of: calendarMonthVM.currentIndex) { _, newValue in
                        if scrollID != newValue {
                            withAnimation {
                                scrollID = newValue
                            }
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if calendarMonthVM.currentIndex != Global.CENTER_PAGE {
                            GoToTodayButtonView(currentIndex: $calendarMonthVM.currentIndex)
                                .allowsHitTesting(true)
                                .padding(.horizontal, 20)
                        }
                    }
                    Text("vstack 안")
                    
                    Divider()
                }// Vstack
                ScheduleListView(
//                    mode: $calendarMonthVM.scheduleSheet,
                    holidays: calendarMonthVM.holidays(for: calendarMonthVM.selectedDateModel),
                    schedules: calendarMonthVM.schedules(for: calendarMonthVM.selectedDateModel),
                    selectedDateModel: calendarMonthVM.selectedDateModel) { schedule in
                        calendarMonthVM.editSchedule(model: schedule)
                    }
                Divider()
                Text("vstack 밖")
    //                .frame(maxWidth: .infinity, maxHeight: .infinity)
    //                .containerRelativeFrame(.horizontal)
    //                .containerRelativeFrame(.vertical)
                    .background(.red)
                
            }
        }
        .sheet(item: $calendarMonthVM.scheduleSheet) { mode in
            AddScheduleView(
                scheduleRepo: calendarMonthVM.scheduleRepo,
                holidays: calendarMonthVM.holidays(for: mode.dateModel),
                dateColor: calendarMonthVM.dateColor(for: mode.dateModel),
                schedules: calendarMonthVM.schedules(for: mode.dateModel),
                mode:mode
            )
        }
        

    }
}

struct MonthGridView : View  {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    
    let index : Int
    var body: some View{
        
        VStack(){
            
            LazyVGrid(columns: calendarMonthVM.weeks){
                ForEach(calendarMonthVM.monthCache[index] ?? [], id: \.self.id){ weekday in
                    DayCellView(
//                        showingSheet: $calendarMonthVM.showingSheet,
                        calendarMonthVM: calendarMonthVM,
                        calendarDateModel: weekday,
                        holidays: calendarMonthVM.holidays(for:weekday),
                        dateColor: calendarMonthVM.dateColor(for: weekday),
                        schedules: calendarMonthVM.schedules(for: weekday)
                    )
                    .opacity(weekday.type != .current ? 0.2 : 1)
                    .overlay{
                        // 선택되면 약간 빛나는 느낌으로
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(
                                calendarMonthVM.isSelected(id: weekday.id) ? Color.primary : Color.clear,
                                style: StrokeStyle(lineWidth: 2)
                            )
                        
                    }
                }
                
                    
            }
        }
        
        .padding()
        .id(index)
        
        .onAppear{
            Task{@MainActor in
                calendarMonthVM.monthGridViewDataUpdate(index : index)
                //MARK:  onappear될때 마다 호출 되는거 바꾸기
                calendarMonthVM.holidayRepo.setFixedHoliday(index: index)
                //                print("dslkjflskdjflskdjf")
            }
            
            
        }
        
    }
    
}



#Preview {
    //    MonthView(calendarMonthVM:CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: MockScheduleRepository()))
    CalendarView(calendarMonthVM: .mock)
}
