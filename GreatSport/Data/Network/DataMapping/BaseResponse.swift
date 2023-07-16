//
//  BaseResponse.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//

import Foundation

struct BaseResponse<T: Decodable> : Decodable {
    enum CodingKeys: String, CodingKey
    {
        case data = "data"
        case message = "message"
        case code = "status"
        case per_page = "per_page"
        case total = "total"
    }
    
    let data: T
    let message : String
    let code : Int
    let per_page : Int?
    let total : Int?
}


struct EmptyResponse : Decodable
{
   
}
