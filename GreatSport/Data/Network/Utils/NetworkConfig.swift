//
//  NetworkConfig.swift
//  Mawa
//
//  Created by Mohammed Jarkas on 04/01/2022.
//


import Foundation
import UIKit
import SwiftyUserDefaults

public struct ApiDataNetworkConfig {
    public let baseURL: URL
    public let headers: [String: String]
    
    public init() {
        self.baseURL =  URL(string: "https://ios.app99877.com/api/")!
        self.headers = generateHeaders()
    }
}

func generateHeaders() ->[String:String] {
    var headers = [String:String]()

    let DEVICE_UUID = "X-device-uuid"
    let INPUT_DIVICE_TYPE = "DEVICE_TYPE"
    let INPUT_ACCEPT = "Accept"
    let OUTPUT_ACCESS_TOKEN_HEADER = "Authorization"
    headers[INPUT_DIVICE_TYPE] = "ios"
    headers[DEVICE_UUID] = device_uuid
//    headers["X-device-model"] = UIDevice.modelName
//    headers["X-device-version"] = "\(UIDevice.current.systemVersion)"
//    headers["X-application-version"] = "1.0"
//    headers["Accept-Language"] = appLanguage.rawValue
    headers["Accept-Encoding"] = "gzip, deflate, br"
    headers[INPUT_ACCEPT] = "application/json"
 
    return headers
}

public protocol NetworkCancellable {
    func cancel()
}
