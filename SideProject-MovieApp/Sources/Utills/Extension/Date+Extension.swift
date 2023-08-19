//
//  Date+Extension.swift
//  SideProject-MovieApp
//
//  Created by 이동기 on 2023/08/19.
//

import Foundation

extension Date {
    
    static func checkOverOneMonth(from changedDate: Date?) -> Bool {
        guard let changedDate = changedDate else { return false }
        let currentDate = Date()
            
        if (changedDate + 86400 * 30) < currentDate {
            return true
        } else {
            return false
        }
    }
    
    static func stringToDate(from stringDate: String?) -> Date? {
        guard let stringDate = stringDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let convertedDate = dateFormatter.date(from: stringDate)
        return convertedDate
    }
    
    static func dateToString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
