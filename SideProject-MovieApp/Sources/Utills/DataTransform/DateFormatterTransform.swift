//
//  DateFormatterTransform.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/08/25.
//

import Foundation

final class DateFormatterManager {
    private init() {}
    static let shared = DateFormatterManager()
    
    let inputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    let outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    let outputFormatterInDayMinute: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.HH.mm"
        return formatter   
    }()
    
    func convertDateToYears(_ dateString: String) -> String? {
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func convertDateToMinute(_ dateString: String) -> String? {
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatterInDayMinute.string(from: date)
        }
        return nil
    }
}
