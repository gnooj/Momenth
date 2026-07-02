//
//  HolidayModel.swift
//  YOMO
//
//  Created by 김현중 on 4/12/26.
//

import Foundation

struct HolidayModel: Codable, Hashable, Identifiable {
    var id = UUID()
    let dateName: String
//    let locdate: Int
    let year: Int
    let month: Int
    let day: Int
}
