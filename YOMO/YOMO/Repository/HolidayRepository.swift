//
//  HolidayRepository.swift
//  YOMO
//
//  Created by 김현중 on 4/10/26.
//

import Foundation
import FirebaseFirestore

class HolidayRepository : ObservableObject{
    
    @Published private(set) var holidaysDictionary : [Int : [HolidayModel]] = [:]
    var calendar = Calendar.current
    var loadedYears = Set<Int>()
    func setFixedHoliday(index : Int) -> Void {
        print("SetFix 호춣 ~!")
        let offset = index - Global.CENTER_PAGE
        let targetDate = calendar.date(byAdding: .month, value: offset, to: Date())!
        let centerYear = calendar.component(.year, from: targetDate)
        for year in (centerYear - 5) ... (centerYear + 5){
            guard !loadedYears.contains(year) else { continue }
            loadedYears.insert(year)
            for item in HolidayData.fixeditem {
                let key = (year * 100 + item.1) * 100 + item.2
                let model = HolidayModel(dateName: item.0, year: year, month: item.1, day: item.2)
                holidaysDictionary[key, default: []].append(model)
            }
        }
    }
    func setLunarHolidayDictinary() -> Void {
        for item in HolidayData.lunar {
            let key = (item.year * 100 + item.month) * 100 + item.day
            holidaysDictionary[key, default: []].append(item)
        }
    }
}
enum HolidayData {
    static let fixeditem : [(String,Int, Int)] = [
        ("새해 첫날",01,01),
        ("삼일절",03,01),
        ("노동절",05,01),
        ("어린이날",05,05),
        ("현충일",06,06),
        ("제헌절",07,17),
        ("광복절",08,15),
        ("개천절", 10,03),
        ("한글날", 10,09),
        ("성탄절", 12,25)

    ]
    //2020 ~ 2036
    static let lunar : [HolidayModel] = [
        HolidayModel(dateName:"설날",year:2020, month:01, day:25)
        ,HolidayModel(dateName:"설날 연휴",year:2020, month:01, day:24)
        ,HolidayModel(dateName:"설날 연휴",year:2020, month:01, day:26)
        ,HolidayModel(dateName:"대체공휴일(설날)",year:2020, month:01, day:27)
        ,HolidayModel(dateName:"부처님 오신 날",year:2020, month:04, day:30)
        ,HolidayModel(dateName:"추석",year:2020, month:10, day:01)
        ,HolidayModel(dateName:"추석 연휴",year:2020, month:9, day:30)
        ,HolidayModel(dateName:"추석 연휴",year:2020, month:10, day:02)
        ,HolidayModel(dateName:"설날",year:2021, month:02, day:12)
        ,HolidayModel(dateName:"설날 연휴",year:2021, month:02, day:11)
        ,HolidayModel(dateName:"설날 연휴",year:2021, month:02, day:13)
        ,HolidayModel(dateName:"부처님 오신 날",year:2021, month:05, day:19)
        ,HolidayModel(dateName:"추석",year:2021, month:09, day:21)
        ,HolidayModel(dateName:"추석 연휴",year:2021, month:09, day:20)
        ,HolidayModel(dateName:"추석 연휴",year:2021, month:09, day:22)
        ,HolidayModel(dateName:"설날",year:2022, month:02, day:01)
        ,HolidayModel(dateName:"설날 연휴",year:2022, month:01, day:31)
        ,HolidayModel(dateName:"설날 연휴",year:2022, month:02, day:02)
        ,HolidayModel(dateName:"부처님 오신 날",year:2022, month:05, day:08)
        ,HolidayModel(dateName:"추석",year:2022, month:09, day:10)
        ,HolidayModel(dateName:"추석 연휴",year:2022, month:09, day:09)
        ,HolidayModel(dateName:"추석 연휴",year:2022, month:09, day:11)
        ,HolidayModel(dateName:"대체공휴일(추석)",year:2022, month:09, day:12)
        ,HolidayModel(dateName:"설날",year:2023, month:01, day:22)
        ,HolidayModel(dateName:"설날 연휴",year:2023, month:01, day:21)
        ,HolidayModel(dateName:"설날 연휴",year:2023, month:01, day:23)
        ,HolidayModel(dateName:"대체공휴일(설날)",year:2023, month:01, day:24)
        ,HolidayModel(dateName:"부처님 오신 날",year:2023, month:05, day:27)
        ,HolidayModel(dateName:"대체공휴일(부처님 오신 날)",year:2023, month:05, day:29)
        ,HolidayModel(dateName:"추석",year:2023, month:09, day:29)
        ,HolidayModel(dateName:"추석 연휴",year:2023, month:09, day:28)
        ,HolidayModel(dateName:"추석 연휴",year:2023, month:09, day:30)
        ,HolidayModel(dateName:"설날",year:2024, month:02, day:10)
        ,HolidayModel(dateName:"설날 연휴",year:2024, month:02, day:09)
        ,HolidayModel(dateName:"설날 연휴",year:2024, month:02, day:11)
        ,HolidayModel(dateName:"대체공휴일(설날)",year:2024, month:02, day:12)
        ,HolidayModel(dateName:"부처님 오신 날",year:2024, month:05, day:15)
        ,HolidayModel(dateName:"추석",year:2024, month:09, day:17)
        ,HolidayModel(dateName:"추석 연휴",year:2024, month:09, day:16)
        ,HolidayModel(dateName:"추석 연휴",year:2024, month:09, day:18)
        ,HolidayModel(dateName:"설날",year:2025, month:01, day:29)
        ,HolidayModel(dateName:"설날 연휴",year:2025, month:01, day:28)
        ,HolidayModel(dateName:"설날 연휴",year:2025, month:01, day:30)
        ,HolidayModel(dateName:"부처님 오신 날",year:2025, month:05, day:05)
        ,HolidayModel(dateName:"추석",year:2025, month:10, day:06)
        ,HolidayModel(dateName:"추석 연휴",year:2025, month:10, day:05)
        ,HolidayModel(dateName:"추석 연휴",year:2025, month:10, day:07)
        ,HolidayModel(dateName:"대체공휴일(추석)",year:2025, month:10, day:08)
        ,HolidayModel(dateName:"설날",year:2026, month:02, day:17)
        ,HolidayModel(dateName:"설날 연휴",year:2026, month:02, day:16)
        ,HolidayModel(dateName:"설날 연휴",year:2026, month:02, day:18)
        ,HolidayModel(dateName:"부처님 오신 날",year:2026, month:05, day:24)
        ,HolidayModel(dateName:"추석",year:2026, month:09, day:25)
        ,HolidayModel(dateName:"추석 연휴",year:2026, month:09, day:24)
        ,HolidayModel(dateName:"추석 연휴",year:2026, month:09, day:26)
        ,HolidayModel(dateName:"설날",year:2027, month:02, day:07)
        ,HolidayModel(dateName:"설날 연휴",year:2027, month:02, day:06)
        ,HolidayModel(dateName:"설날 연휴",year:2027, month:02, day:08)
        ,HolidayModel(dateName:"대체공휴일(설날)",year:2027, month:02, day:09)
        ,HolidayModel(dateName:"부처님 오신 날",year:2027, month:05, day:13)
        ,HolidayModel(dateName:"추석",year:2027, month:09, day:15)
        ,HolidayModel(dateName:"추석 연휴",year:2027, month:09, day:14)
        ,HolidayModel(dateName:"추석 연휴",year:2027, month:09, day:16)
        ,HolidayModel(dateName:"설날",year:2028, month:01, day:27)
        ,HolidayModel(dateName:"설날 연휴",year:2028, month:01, day:26)
        ,HolidayModel(dateName:"설날 연휴",year:2028, month:01, day:28)
        ,HolidayModel(dateName:"부처님 오신 날",year:2028, month:05, day:02)
        ,HolidayModel(dateName:"추석",year:2028, month:10, day:03)
        ,HolidayModel(dateName:"추석 연휴",year:2028, month:10, day:02)
        ,HolidayModel(dateName:"추석 연휴",year:2028, month:10, day:04)
        ,HolidayModel(dateName:"설날",year:2029, month:02, day:13)
        ,HolidayModel(dateName:"설날 연휴",year:2029, month:02, day:12)
        ,HolidayModel(dateName:"설날 연휴",year:2029, month:02, day:14)
        ,HolidayModel(dateName:"부처님 오신 날",year:2029, month:05, day:20)
        ,HolidayModel(dateName:"추석",year:2029, month:09, day:22)
        ,HolidayModel(dateName:"추석 연휴",year:2029, month:09, day:21)
        ,HolidayModel(dateName:"추석 연휴",year:2029, month:09, day:23)
        ,HolidayModel(dateName:"설날",year:2030, month:02, day:03)
        ,HolidayModel(dateName:"설날 연휴",year:2030, month:02, day:02)
        ,HolidayModel(dateName:"설날 연휴",year:2030, month:02, day:04)
        ,HolidayModel(dateName:"부처님 오신 날",year:2030, month:05, day:09)
        ,HolidayModel(dateName:"추석",year:2030, month:09, day:12)
        ,HolidayModel(dateName:"추석 연휴",year:2030, month:09, day:11)
        ,HolidayModel(dateName:"추석 연휴",year:2030, month:09, day:13)
        ,HolidayModel(dateName:"설날",year:2031, month:01, day:23)
        ,HolidayModel(dateName:"설날 연휴",year:2031, month:01, day:22)
        ,HolidayModel(dateName:"설날 연휴",year:2031, month:01, day:24)
        ,HolidayModel(dateName:"부처님 오신 날",year:2031, month:05, day:28)
        ,HolidayModel(dateName:"추석",year:2031, month:10, day:01)
        ,HolidayModel(dateName:"추석 연휴",year:2031, month:09, day:30)
        ,HolidayModel(dateName:"추석 연휴",year:2031, month:10, day:02)
        ,HolidayModel(dateName:"설날",year:2032, month:02, day:11)
        ,HolidayModel(dateName:"설날 연휴",year:2032, month:02, day:10)
        ,HolidayModel(dateName:"설날 연휴",year:2032, month:02, day:12)
        ,HolidayModel(dateName:"부처님 오신 날",year:2032, month:05, day:16)
        ,HolidayModel(dateName:"추석",year:2032, month:09, day:19)
        ,HolidayModel(dateName:"추석 연휴",year:2032, month:09, day:18)
        ,HolidayModel(dateName:"추석 연휴",year:2032, month:09, day:20)
        ,HolidayModel(dateName:"설날",year:2033, month:01, day:31)
        ,HolidayModel(dateName:"설날 연휴",year:2033, month:01, day:30)
        ,HolidayModel(dateName:"설날 연휴",year:2033, month:02, day:01)
        ,HolidayModel(dateName:"부처님 오신 날",year:2033, month:05, day:06)
        ,HolidayModel(dateName:"추석",year:2033, month:09, day:08)
        ,HolidayModel(dateName:"추석 연휴",year:2033, month:09, day:07)
        ,HolidayModel(dateName:"추석 연휴",year:2033, month:09, day:09)
        ,HolidayModel(dateName:"설날",year:2034, month:02, day:19)
        ,HolidayModel(dateName:"설날 연휴",year:2034, month:02, day:18)
        ,HolidayModel(dateName:"설날 연휴",year:2034, month:02, day:20)
        ,HolidayModel(dateName:"부처님 오신 날",year:2034, month:05, day:25)
        ,HolidayModel(dateName:"추석",year:2034, month:09, day:27)
        ,HolidayModel(dateName:"추석 연휴",year:2034, month:09, day:26)
        ,HolidayModel(dateName:"추석 연휴",year:2034, month:09, day:28)
        ,HolidayModel(dateName:"설날",year:2035, month:02, day:08)
        ,HolidayModel(dateName:"설날 연휴",year:2035, month:02, day:07)
        ,HolidayModel(dateName:"설날 연휴",year:2035, month:02, day:09)
        ,HolidayModel(dateName:"부처님 오신 날",year:2035, month:05, day:15)
        ,HolidayModel(dateName:"추석",year:2035, month:09, day:16)
        ,HolidayModel(dateName:"추석 연휴",year:2035, month:09, day:15)
        ,HolidayModel(dateName:"추석 연휴",year:2035, month:09, day:17)
        ,HolidayModel(dateName:"설날",year:2036, month:01, day:28)
        ,HolidayModel(dateName:"설날 연휴",year:2036, month:01, day:27)
        ,HolidayModel(dateName:"설날 연휴",year:2036, month:01, day:29)
        ,HolidayModel(dateName:"부처님 오신 날",year:2036, month:05, day:03)
        ,HolidayModel(dateName:"추석",year:2036, month:10, day:04)
        ,HolidayModel(dateName:"추석 연휴",year:2036, month:10, day:03)
        ,HolidayModel(dateName:"추석 연휴",year:2036, month:10, day:05)
        
        //선거일
        ,HolidayModel(dateName:"지방선거일",year:2026, month:06, day:03)
        

    ]

}
