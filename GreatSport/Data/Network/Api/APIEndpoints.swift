//
//  APIEndpoints.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//

import Foundation

struct APIEndpoints {
    static func getPlayersEndPoint() -> Endpoint {
        return Endpoint(path: "sc/players",
                        method: .get)
    }
}



