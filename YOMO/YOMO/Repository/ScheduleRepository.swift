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
class ScheduleRepository : ObservableObject , ScheduleRepositoryProtocol{

    @Published private(set) var schedulesByDay : [Int : [ScheduleModel]] = [:]
    //    @EnvironmentObject()
    //    @Published private(set) var schedules: [ScheduleModel] = [ScheduleModel(title: "dslkfjsdlkjf", startDate: 20260702)]
    let context : ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    func schedules(on dayKey: Int) -> [ScheduleModel] {
        schedulesByDay[dayKey] ?? []
    }

    func insert(_ schedule: ScheduleModel) {
        context.insert(schedule)
        save()
        reload()
    }
    func delete(_ schedule: ScheduleModel) {
        context.delete(schedule)
        save()
        reload()
    }
    func reload()  {
//        var schedules = [ScheduleModel]()
        do {
            print("do 패치 호출")
            let all =  try context.fetch(FetchDescriptor<ScheduleModel>())
            
            schedulesByDay = Dictionary(grouping: all) {
                $0.scheduleKey
            }
            print("schedulesByDay ==== \(schedulesByDay)")
        }catch {
            print("일정을 불러오지 못했습니다.\(error)")
            schedulesByDay = [:]
        }

    }
    func save() {
        try? context.save()
        reload()
    }
}

final class MockScheduleRepository: ScheduleRepositoryProtocol {
    
    
    var storage: [ScheduleModel]
    var schedulesByDay: [Int : [ScheduleModel]] = [:]
    
    init(schedules: [ScheduleModel]) {
        self.storage = schedules
        reload()

    }
    func schedules(on dayKey: Int) -> [ScheduleModel] {
        schedulesByDay[dayKey] ?? []
    }
    func reload() {
        
        schedulesByDay = Dictionary(grouping: storage) {$0.scheduleKey}
        
    }
    
    
    func insert(_ schedule: ScheduleModel) {
        storage.append(schedule)
        reload()
    }
    func delete(_ schedule: ScheduleModel) {
        storage.removeAll { $0 === schedule }
        reload()
    }
    func save(){
        reload()
    }

}
