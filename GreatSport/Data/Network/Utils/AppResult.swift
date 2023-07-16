//
//  AppResult.swift
//  Mawa
//
//  Created by Mohammed Jarkas on 04/01/2022.
//

import Foundation

enum Result<T> {
    
    case success(data: T , code : Int , message : String)
    case failure(AppError?)
    case loading
}



