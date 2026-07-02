//
//  HolidayRepository.swift
//  YOMO
//
//  Created by 김현중 on 4/10/26.
//

import Foundation
import FirebaseFirestore

//class HolidayRepository {
//    
//    var callCount = 0
//    
//    private let db = Firestore.firestore()
//    // 일단 fatchHolidays() 를 만들어서 여기서 데이터를 다 받고 viewmodel에서 에러와 값들을 받아서 관리하는 방식으로 코드 작성예정
//    func fetchHolidays(_ documentId: Int) async throws -> [Int : HolidayModel] {
//        
//        Global.count = Global.count + 1
//        print("fetchHolidays CALL\(Global.count)")
//        
//        var holidayMap : Dictionary<Int, HolidayModel> = [:]
//        callCount += 1
////        let id = documentId % 100000000
//
//        let startId = String(documentId * 100 + 1)
//        let endId = String(documentId * 100 + 30)
//        
//        
//        
//        let docRef = db.collection("holidays")
//            .whereField(FieldPath.documentID(), isGreaterThanOrEqualTo: startId)
//            .whereField(FieldPath.documentID(), isLessThanOrEqualTo: endId)
//            
//        let snapshot = try await docRef.getDocuments()
//        
//        let holidays = snapshot.documents.compactMap { doc in
//            try? doc.data(as: HolidayModel.self)
//        }
//        holidayMap = Dictionary(uniqueKeysWithValues:
//            holidays.map { ($0.locdate, $0)}
//        )
////        for i in 0...holidaysCount {
////            
////        }
//        
////        print("fetcHoliday--------------START------------------------")
////        print("몇월이냐 ==== \(startId)")
////        print("call Count : \(callCount)")
////        print("fetcHoliday---------------END-------------------------")
////        print()
//        return holidayMap
//    }
//    /* 지금 calendargenerator에서 값 넣어주고 있으니까 viewmodel에서 firebaseStore에서 받아 온 값도 같이 보내고 <- 아니다 이건 그냥 다시 생각해보자 왜냐하면 이거 제너레이터에서 만들면 나중에 일정 같은거 추가할때도 제너레이터에서 해야할지 어쩔지가 좀 이상해짐 각각의 코드가 하나의 역할만 하도록 잘 짜보자*/
//    
//}

