//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    @State private var currentIndex : Int? = Global.CENTER_PAGE
    var body: some View {
        VStack{
            MonthTitleView(calendarVM: calendarMonthVM, index: currentIndex!)
            GeometryReader{ gProxy in
                ScrollViewReader{ sProxy in
                    ScrollView(.horizontal, ){
                        LazyHStack(spacing: 0){//lazy로 했을때 문제 생각해보기
                            ForEach(0...calendarMonthVM.totalPage, id: \.self){ index in
                                MonthGridView(calendarMonthVM: calendarMonthVM, index: index)
                                    .drawingGroup()
                                    .frame(
                                        width: gProxy.size.width,
                                        height: gProxy.size.height
                                    )
                                    .id(index)
                            }//ForEach
                        }
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
                    .onAppear {
                        sProxy.scrollTo(currentIndex)
                        
                    }
                }// scrollviewReader
            }// GeometryReader
        }// Vstack
    }
}

struct MonthGridView : View  {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
    let index : Int
    var weeks = Array(repeating: GridItem(), count: 7)
    
    var body: some View{
        
        VStack{
            LazyVGrid(columns: weeks){
                
                ForEach(calendarMonthVM.getMonthData(for: index), id: \.self){ weekday in
                    
                    DayCellView(calendarDateModel: weekday,
                                day: 1, index: index)
                    
                }
            }
            .frame(width: 360, height: 500)
            .padding()
            
        }
    }
}



#Preview {
    MonthView(calendarMonthVM:CalendarMonthViewModel())
}
