//
//  ViewModelType.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/14/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
