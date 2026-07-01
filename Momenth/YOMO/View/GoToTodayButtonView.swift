//
//  GoToTodayButtonView.swift
//  Momenth
//
//  Created by 김현중 on 12/24/25.
//

import SwiftUI

struct GoToTodayButtonView: View {
    @Binding var currentIndex: Int?
    
    var body: some View {
        Button {
            currentIndex = Global.CENTER_PAGE
        } label: {
            Circle()
                .fill(Color(red: 239/255, green: 97/255, blue:42/255))
                .frame(width: 65, height: 111)
        }
        .overlay(
//            Image(systemName: "arrow.uturn.left")
//                .font(.system(size: 25, weight:.black))
//                .foregroundStyle(.background)
            Text("Today")
                .bold()
                .foregroundStyle(.background)
                
        )
        
    }
}

#Preview {
    GoToTodayButtonView(currentIndex: .constant(11))
}
