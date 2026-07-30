//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
//    @State  var currentIndex : Int? = Global.CENTER_PAGE
    //MARK: 여기 viewmodel에서 관리하도록 바꿔야됨 ++ weekdayView만들기
    
    
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
                                        //MARK: 여기 크기 가변으로 바꿔야함
                                            .containerRelativeFrame(.horizontal)
                                            .id(index)
//                                            .background(.gray)
                                    }//ForEach
//                                    .background(.green)
//                                    .frame(height:500)
                                    
                                }//LazyHStack
                                .scrollTargetLayout()

                            }// ScrollView
//                            .background(.blue)
                            .scrollTargetBehavior(.paging)
                            .scrollIndicators(.hidden)
                            .scrollPosition(id: Binding(
                                get: { calendarMonthVM.currentIndex },
                                set: { newValue in
                                    guard let v = newValue else { return }
                                    Task { @MainActor in
                                        calendarMonthVM.currentIndex = v
                                    }
                                }
                            ))

                            //MARK: go to taday
                            .overlay(alignment: .bottomTrailing){
                                if calendarMonthVM.currentIndex != Global.CENTER_PAGE{
                                    GoToTodayButtonView(
                                        currentIndex: Binding(
                                            get: { calendarMonthVM.currentIndex },
                                            set: { newValue in
                                                Task { @MainActor in
                                                    calendarMonthVM.currentIndex = newValue
                                                }
                                            }
                                        )
                                    )
                                        .allowsHitTesting(true)
                                        .padding(.horizontal, 20)
                                }
                                
                            }

                    Text("vstack 안")
                }// Vstack
//                .background(.red)
                Text("vstack 밖")
                
//                .background(.green)
                
//                VStack{
//                    Text("KJDKJF")
//                }
////                .frame(width: 300, height: 300)
//                .foregroundStyle(.red)
                
            }.overlay {
                ZStack{
                    if calendarMonthVM.addScheduleTrigger {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.1)) {calendarMonthVM.addScheduleTrigger = false}
                            }
                            .transition(.opacity)
                        AddScheduleView(selectedDateModel: calendarMonthVM.selectedDateModel, scheduleRepo: calendarMonthVM.scheduleRepo,holidays: calendarMonthVM.holidayName(for: calendarMonthVM.selectedDateModel),dateColor: calendarMonthVM.dateColor(for: calendarMonthVM.selectedDateModel), isSelected: calendarMonthVM.isSelected(id: calendarMonthVM.selectedDateModel.id))
                    }

                }
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
                        DayCellView(calendarMonthVM: calendarMonthVM, calendarDateModel: weekday)
                            .opacity(weekday.type != .current ? 0.2 : 1)
                            .overlay{
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder(
                                        calendarMonthVM.isSelected(id: weekday.id) ? Color.primary : Color.clear,
                                        style: StrokeStyle(lineWidth: 2)
                                    )
                            }
    //                        .blur(radius: 3)
                    }
//                    .background(.blue)
    //                Spacer()
                }
//                .background(.red)
            }
//        .background(.green)
//        .frame(width: 100, height: 200)
            
            .padding()
            .id(index)
             
//            Spacer()
        
//        .background(.red)
        .onAppear{
            Task{@MainActor in
                calendarMonthVM.loadMonthGridViewData(index : index)
                calendarMonthVM.holidayRepo.setFixedHoliday(index: index)
            }
            print("sdkdfs")
//            if !calendarMonthVM.monthGridViewLoded {
            

//                calendarMonthVM.monthGridViewLoded = true
//                print("index ======================= \(index)")
//            }
        }

    }
    
}



#Preview {
    MonthView(calendarMonthVM:CalendarMonthViewModel(holidayRepo: HolidayRepository(), scheduleRepo: ScheduleRepository()))
}
