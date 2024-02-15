//
//  DateFormatType.swift
//  Purple
//
//  Created by Seungyeon Kim on 2/14/24.
//

import Foundation

enum DateFormatType: String {
    
    case toAPI = "yyyy-MM-dd HH:mm:ss.SSS"
    case fullWithDot = "yy. MM. dd"
    
    case fromAPI = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    case timeAMPM = "hh:mm a"
    
    case monthday = "M/d"
    
    
//    case dmCellNotToday = "yyyysus M월 d일"
//    case dmCellToday = "a hh:mm"
}
