//
//  ContentView.swift
//  Momenth
//
//  Created by 김현중 on 9/9/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject private var calendarMonthVM = CalendarMonthViewModel()
    
    //처음 시작은 오늘로 그 후 변경되는 값들을 보내서 달력 update
//    @StateObject로 받았으니까 하위뷰에서는 observable로 받아서 사용하기
    
    
    
    var body: some View {
        VStack{
            MonthView(calendarMonthVM:calendarMonthVM)
            
        }
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

