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
            VStack(){
                
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
                
                GeometryReader{ gProxy in
                    ScrollViewReader{ sProxy in
                        ScrollView(.horizontal){
                            LazyHStack(alignment:.top,spacing: 0){//lazy로 했을때 문제 생각해보기
                                ForEach(0...calendarMonthVM.totalPage, id: \.self){ index in
                                    MonthGridView(calendarMonthVM: calendarMonthVM, index: index)
                                        .frame(
                                            width: gProxy.size.width,
                                            height: gProxy.size.height
                                        )
                                        .id(index)
                                }//ForEach
                            }//LazyHStack
                            .scrollTargetLayout()
                        }// ScrollView
                        .scrollTargetBehavior(.paging)
                        .scrollIndicators(.hidden)
                        .scrollPosition(id: Binding(get: {calendarMonthVM.currentIndex},
                                                    set: { if let v = $0 { calendarMonthVM.currentIndex = v } }))
    //                    .onChange(of: currentIndex) { oldValue,newValue in
    //                        if let newValue = newValue{
    //                            calendarMonthVM.onPageChanged(to: newValue)
    //                        }
    //                    }
                        
                        //MARK: go to taday
                        .overlay(alignment: .bottomTrailing){
                            if calendarMonthVM.currentIndex != Global.CENTER_PAGE{
                                GoToTodayButtonView(
                                    currentIndex: Binding(get: { calendarMonthVM.currentIndex },
                                                          set: { calendarMonthVM.currentIndex = $0 }
                                                         )
                                )
                                    .allowsHitTesting(true)
                                    .padding(.horizontal, 20)
                            }
                            
                        }
                        
                        
                        
                    }// scrollviewReader
                    
                }// GeometryReader
            }// Vstack
            .overlay {
                ZStack{
                    if calendarMonthVM.addScheduleTrigger {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.1)) {calendarMonthVM.addScheduleTrigger = false}
                            }
                            .transition(.opacity)
                        AddScheduleView()
                    }

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
//                        .blur(radius: 3)
                }
                Spacer()
            }
            .padding()
            .id(index)
             
            Spacer()
        }
        .onAppear{
            
//            if !calendarMonthVM.monthGridViewLoded {
            calendarMonthVM.loadMonthGridViewData(index : index)
            calendarMonthVM.setFixedHoliday(index: index)

//                calendarMonthVM.monthGridViewLoded = true
//                print("index ======================= \(index)")
//            }
        }
    }
    
}



#Preview {
    MonthView(calendarMonthVM:CalendarMonthViewModel())
}
