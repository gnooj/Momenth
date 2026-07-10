//
//  AddScheduleRepository.swift
//  YOMO
//
//  Created by 김현중 on 7/2/26.
//

import Foundation
import SwiftData
//스케쥴 한번에 관리 생성,저장,삭제,업데이트
//스케쥴 데이터도 여기서 하나만 관리
class ScheduleRepository : ObservableObject {
    
    @Published private(set) var schedules: [ScheduleModel] = [ScheduleModel(title: "dslkfjsdlkjf", startDate: 20260702)]
    
    
    
}
