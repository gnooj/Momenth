//
//  CalendarView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct MonthView: View {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
//    @State private var currentKey : String? = ""
//    @State private var displayKey : String? = ""
    @State private var currentIndex : Int? = Global.CENTER_PAGE
    var body: some View {
        
        
        VStack{
//            if let displayKey = displayKey {
            MonthTitleView(calendarVM: calendarMonthVM, index: currentIndex!)
//            }
            
            GeometryReader{ gProxy in
                ScrollViewReader{ sProxy in
                    ScrollView(.horizontal, ){
                        LazyHStack(spacing: 0){//lazy로 했을때 문제 생각해보기
                            
                            //key 를 여기서 관리하지말고 전역으로 관리할 수 있도록 하기
                            ForEach(0...calendarMonthVM.totalPage, id: \.self){ index in
                                
                                MonthGridView(calendarMonthVM: calendarMonthVM, index: index)
                                    .drawingGroup()
                                    .frame(
                                        width: gProxy.size.width,
                                        height: gProxy.size.height
                                    )
                                    .id(index)
                                
                            }

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
                        
                        print(currentIndex)
//                        calendarMonthVM.currentMonthKey = newValue ?? calendarMonthVM.currentMonthKey
//
////                        print("\(oldValue) -> \(calendarMonthVM.currentDate)")
//                        if let newValue = newValue, newValue == calendarMonthVM.monthKeys.last {
////                            print("\(currentKey)")
//                            calendarMonthVM.getNextMonth(newValue, 1)
//                            
//                        }
//                        if let newValue = newValue, newValue == calendarMonthVM.monthKeys.first {
//                            
////                            print("view == 현재 키\(currentKey)")
//                            print("prevmonthcall\n")
//                            print("view montnkeys == \(calendarMonthVM.monthKeys)")
//                            
//                            calendarMonthVM.getNextMonth(newValue, -1)
//
//                        }
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now()+0.25){
//                                displayKey = currentKey
//                            }
                    }
                    
                    
                    .onAppear {
                        sProxy.scrollTo(currentIndex)
                        // 현재 월로 스크롤
//                        print("onappear = \(currentKey)" )
                        
                        
                    }
                }// scrollviewReader
                
                
            
                
            }
        }
        
    }
}

struct MonthGridView : View  {
    
    @ObservedObject var calendarMonthVM : CalendarMonthViewModel
    
//    let monthKey : String
    let index : Int
    
    
    var weeks = Array(repeating: GridItem(), count: 7)
    
    
    
    var body: some View{
        
        VStack{
            
            
            LazyVGrid(columns: weeks){
                //여기서 넘겨줄때 getCurrentMonthDatesCount <-이거 함수 사용하지 않고 여기서도 계산속성으로 계산해서 사용
                ForEach(calendarMonthVM.monthCache[index]?.dates ?? [], id: \.self){ weekday in
                    
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
