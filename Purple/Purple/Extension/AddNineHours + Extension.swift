//
//  AddNineHours + Extension.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/15/24.
//

import Foundation

//9시간 더하기
func addNineHours(to date: Date) -> Date {
    
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.hour = 9
    guard let newDate = calendar.date(byAdding: dateComponents, to: date) else {
        
        print("변환 실패")
        
        return date
    }
    return newDate
}
