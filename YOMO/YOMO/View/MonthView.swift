//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    @State private var scrollID: Int? = Global.CENTER_PAGE
    @State private var showingSheet: Bool = false
    var body: some View {
        
        VStack{
            VStack{
                
                MonthTitleView(calendarVM: calendarMonthVM, index: calendarMonthVM.currentIndex)
                
                VStack {
                    LazyVGrid(columns: calendarMonthVM.weeks, spacing: 0){
                        ForEach(calendarMonthVM.dayOfTheWeek, id: \.self){ week in
                            Text("\(week)")
                                .font(.caption)
                        }
                        .frame(width: 360)
                    }
                }
                .padding(.horizontal, 15)
                
                ScrollView(.horizontal){
                    LazyHStack(alignment:.top,spacing: 0){//lazy로 했을때 문제 생각해보기
                        ForEach(0...calendarMonthVM.totalPage, id: \.self){ index in
                            MonthGridView(calendarMonthVM: calendarMonthVM, index: index)
                                .containerRelativeFrame(.horizontal)
                                .id(index)
                        }//ForEach
                        
                    }//LazyHStack
                    .scrollTargetLayout()
                    
                }// ScrollView
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
            }// Vstack
            
            Text("vstack 밖")
            
        }.overlay {
//            ZStack{
//                if calendarMonthVM.addScheduleTrigger {
//                    Color.black.opacity(0.5)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            //MARK: - 여기 지금 바꿔야댐 전체 에니메이션으로 지금은 세이프에어리어 누를때만 들어가있음
//                            withAnimation(.easeInOut(duration: 0.15)) {calendarMonthVM.addScheduleTrigger = false}
//                            print("sdfsf\(calendarMonthVM.selectedDateModel.holidayDicKey)")
//                        }
//                        .transition(.opacity)
//                    AddScheduleView(
//                        selectedDateModel:calendarMonthVM.selectedDateModel,
//                        scheduleRepo: calendarMonthVM.scheduleRepo,
//                        addScheduleTrigger: $calendarMonthVM.addScheduleTrigger,
//                        holidays:calendarMonthVM.holidays(for: calendarMonthVM.selectedDateModel),
//                        dateColor: calendarMonthVM.dateColor(for: calendarMonthVM.selectedDateModel),
//                        schedules: calendarMonthVM.schedules(for: calendarMonthVM.selectedDateModel)
//                        
//                    )
//                    
//                }
//
//                    
//                
//            }
        }
    }
}

struct MonthGridView : View  {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    
    let index : Int
    var body: some View{
        
        VStack(alignment: .leading){
            
            LazyVGrid(columns: calendarMonthVM.weeks){
                ForEach(calendarMonthVM.monthCache[index] ?? [], id: \.self.id){ weekday in
                    DayCellView(
                        showingSheet: $calendarMonthVM.showingSheet,
                        calendarMonthVM: calendarMonthVM,
                        calendarDateModel: weekday,
                        holidays: calendarMonthVM.holidays(for:weekday),
                        dateColor: calendarMonthVM.dateColor(for: weekday),
                        schedules: calendarMonthVM.schedules(for: weekday)
                    )
                    .sheet(isPresented: $calendarMonthVM.showingSheet) {
                        AddScheduleView(
                            selectedDateModel:calendarMonthVM.selectedDateModel,
                            scheduleRepo: calendarMonthVM.scheduleRepo,
                            addScheduleTrigger: $calendarMonthVM.addScheduleTrigger,
                            holidays:calendarMonthVM.holidays(for: calendarMonthVM.selectedDateModel),
                            dateColor: calendarMonthVM.dateColor(for: calendarMonthVM.selectedDateModel),
                            schedules: calendarMonthVM.schedules(for: calendarMonthVM.selectedDateModel)
                            
                        )
                    }
                        .opacity(weekday.type != .current ? 0.2 : 1)
                        .overlay{
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
                calendarMonthVM.holidayRepo.setFixedHoliday(index: index)
                //                print("dslkjflskdjflskdjf")
            }
            
            
        }
        
    }
    
}



#Preview {
    //    MonthView(calendarMonthVM:CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: MockScheduleRepository()))
    MonthView(calendarMonthVM: .mock)
}
