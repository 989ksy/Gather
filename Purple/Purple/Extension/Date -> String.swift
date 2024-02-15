//
//  Date -> String.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/14/24.
//

import Foundation

extension String {
    func toDate(to type: DateFormatType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = type.rawValue
        return dateFormatter.date(from: self)
    }
}


extension Date {
    func toString(of type: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = type.rawValue
        return dateFormatter.string(from: self)
    }
}

