//
//  DayCellView.swift
//  Momenth
//
//  Created by 김현중 on 9/19/25.
//

import SwiftUI

struct DayCellView: View {
    
    var day: Int
    
    
    var body: some View {
        
        Text("\(day)")
            .frame(width: 45, height: 73, alignment: .top)
            .font(.title3)
            .background(Color(.systemGray3))
            .cornerRadius(5)
            
    }
        
}

#Preview {
    DayCellView(day: 1)
}
