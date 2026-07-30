//
//  ScheduleRepositoryProtocol.swift
//  YOMO
//
//  Created by 김현중 on 7/16/26.
//

import Foundation

protocol ScheduleRepositoryProtocol {
//    func fetchAll() throws  -> [ScheduleModel]
    func schedules(on dayKey: Int) -> [ScheduleModel]
    func insert(_ schedule: ScheduleModel) throws
    func delete(_ schedule: ScheduleModel) throws
    func reload() 
}
