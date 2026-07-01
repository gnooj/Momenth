//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    @State  var currentIndex : Int? = Global.CENTER_PAGE
    //MARK: 여기 viewmodel에서 관리하도록 바꿔야됨 ++ weekdayView만들기
    var dayOfTheWeek = Array(arrayLiteral: "일", "월", "화", "수", "목", "금", "토")
    
    var body: some View {
        VStack(){

                MonthTitleView(calendarVM: calendarMonthVM, index: currentIndex!)

            VStack {
                LazyVGrid(columns: calendarMonthVM.weeks, spacing: 0){
                    ForEach(dayOfTheWeek, id: \.self){ week in
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
                    .scrollPosition(id: $currentIndex)
                    .onChange(of: currentIndex) { oldValue,newValue in
                        if let newValue = newValue{
                            calendarMonthVM.onPageChanged(to: newValue)
                        }
                    }

                    //MARK: go to taday
                    .overlay(alignment: .bottomTrailing){
                        if currentIndex==Global.CENTER_PAGE{
                            EmptyView()
                        }else {
                        Spacer()
                        GoToTodayButtonView(currentIndex: $currentIndex)
                            .allowsHitTesting(true)
                            .padding(.horizontal, 20)
                        }
                        
                    }
                    
                    

                }// scrollviewReader
                
            }// GeometryReader
        }// Vstack
        

    }
}

struct MonthGridView : View  {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    @State private var monthData : [CalendarDateModel] = []
    @State private var isLoaded : Bool = false
    
    let index : Int
    var body: some View{
        
        VStack(alignment: .leading){
            LazyVGrid(columns: calendarMonthVM.weeks){
                ForEach(monthData, id: \.self.id){ weekday in
                    DayCellView(calendarMonthVM: calendarMonthVM, calendarDateModel: weekday, index: index)
                }
                Spacer()
            }
            .padding()
            .id(index)
            
            Spacer()
        }
        .onAppear{
            if !isLoaded {
                monthData = calendarMonthVM.getMonthData(for: index)
                isLoaded = true
            }
        }
    }
    
}



#Preview {
    MonthView(calendarMonthVM:CalendarMonthViewModel())
}
