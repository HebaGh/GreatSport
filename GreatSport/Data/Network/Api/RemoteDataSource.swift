//
//  RemoteDataSource.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//

import Foundation
import UIKit
import Alamofire

// MARK: - Remote Data Source
class RemoteDataSource {
    
    func sendRequest<T>(_ request: URLRequest , param : [String : Any] ,completion: @escaping  (Result<T>) -> Void) where T: Decodable {
        
        print(request.url)
        print(request.method)
        print(request)
        print(param)
        AF.request(request.url!.absoluteString, method: request.method!, parameters: param , headers: request.headers)
        
            .responseJSON(completionHandler: { (response) in
                print(response.data)
                print(response.result)
                
                
            })
            .responseDecodable(of: BaseResponse<T>.self) { (response) in
                
                switch response.result {
                    
                case .success(let res):
                    
                    if res.code == 1 {
                        print(res.data)
                        print(res.message)
                        completion(.success(data: res.data , code : res.code , message: res.message ))
                        
                    } else {
                        
                        let statusCode = res.code
                        
                        if let reason = GetFailureReason(rawValue: statusCode) {
                            
                            let appError = AppError(reason: reason, message: res.message)
                            
                            completion(.failure(appError))
                            
                        } else {
                            
                            completion(.failure(AppError(reason: nil , message: res.message)))
                        }
                        
                    }
                case .failure(_):
                    print(response.response?.statusCode)
                    if response.response?.statusCode == nil
                    {
                        let reason = GetFailureReason(rawValue: 0)
                         
                         let appError = AppError(reason: reason, message: "unknown error")
                         
                         completion(.failure(appError))
                    }else
                    if let statusCode = response.response?.statusCode,
                       let reason = GetFailureReason(rawValue: statusCode) {
                        
                        let appError = AppError(reason: reason, message: "unknown error")
                        
                        completion(.failure(appError))
                        
                    }
                    else {
                        
                        let response = try? JSONDecoder().decode(BaseResponse<EmptyResponse>.self, from: response.data!)
                        
                        if let code = response?.code {
                            
                            if code != 200 {
                                
                                if  let reason = GetFailureReason(rawValue: code) {
                                    
                                    let appError = AppError(reason: reason, message: response?.message)
                                    
                                    completion(.failure(appError))
                                    
                                }else{
                                    completion(.failure(AppError(reason: nil , message: response?.message )))
                                }
                            }
                            else{
                                completion(.failure(AppError(reason: nil , message: response?.message )))
                            }
                        }
                        
                    }
                }
            }
    }
    
    
    func sendRequestWithFile<T>(_ request: URLRequest , param : [String : Any] , file : Data? = nil  , mainImage : Data ,completion: @escaping  (Result<T>) -> Void) where T: Decodable {
        
        print(param)
        
        AF.upload(multipartFormData:{ multipartFormData in
            
          
            if file != nil
            {
                let filedata =  file! // Getting file data here
                print(filedata)
            multipartFormData.append(filedata, withName: "file" , fileName:   "cv.pdf", mimeType: "application/pdf")
            }
            multipartFormData.append( mainImage , withName: "mainImage" , fileName: UUID().uuidString  + ".jpg", mimeType: "image/jpg")
            
            //               } catch {
            //                  print("document loading error")
            //               }
            
            for (key, value) in param {
                print("\(value)".data(using: .utf8)!)
                if key == "file" || key == "mainImage"
                {
                    print("we skip file")
                }
                if key == "aminitiesIds"
                {
                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    multipartFormData.append(arrData, withName: key as String)
                }
             
                
                
                //                if key == "aminitiesIds" {
                //                    let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                //                    multipartFormData.append(arrData, withName: key as String)
                //                }
                else{
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
            
        },to : request.url!.absoluteString , usingThreshold: UInt64.init() , method: request.method!, headers: request.headers)
        
            .responseJSON(completionHandler: { (response) in
                print(response.data)
                print(response.result)
                
                
            })
            .responseDecodable(of: BaseResponse<T>.self) { (response) in
                
                switch response.result {
                    
                case .success(let res):
                    
                    if res.code == 200 {
                        print(res.data)
                        print(res.message)
                        completion(.success(data: res.data , code : res.code , message: res.message ))
                        
                    } else {
                        
                        let statusCode = res.code
                        
                        if let reason = GetFailureReason(rawValue: statusCode) {
                            
                            let appError = AppError(reason: reason, message: res.message)
                            
                            completion(.failure(appError))
                            
                        } else {
                            
                            completion(.failure(AppError(reason: nil , message: res.message)))
                        }
                        
                    }
                case .failure(_):
                    
                    if let statusCode = response.response?.statusCode,
                       let reason = GetFailureReason(rawValue: statusCode) {
                        
                        let appError = AppError(reason: reason, message: "unknown error")
                        
                        completion(.failure(appError))
                        
                    } else {
                        
                        if response.data != nil {
                            
                            let response = try? JSONDecoder().decode(BaseResponse<EmptyResponse>.self, from: response.data!)
                            
                            if let code = response?.code {
                                
                                if code != 200 {
                                    
                                    if  let reason = GetFailureReason(rawValue: code) {
                                        
                                        let appError = AppError(reason: reason, message: response?.message)
                                        
                                        completion(.failure(appError))
                                        
                                    }else{
                                        completion(.failure(AppError(reason: nil , message: response?.message )))
                                    }
                                }
                                else{
                                    completion(.failure(AppError(reason: nil , message: response?.message )))
                                }
                            }
                            
                        } else {
                            
                            completion(.failure(AppError(reason: nil , message: nil )))
                        }
                       
                        
                    }
                }
            }
    }
    
    
    
    func uploadImages<T>(_ request: URLRequest , param : [String : Any] , video : Data? , images : [Data] ,completion: @escaping  (Result<T>) -> Void) where T: Decodable {
        
        print(param)
        
        AF.upload(multipartFormData:{ multipartFormData in
            
            
            for i in 0 ..< images.count
            {
                multipartFormData.append(images[i], withName: "images[\(i)]" , fileName: UUID().uuidString  + ".jpg", mimeType: "image/jpg")
                
                
            }
            
            if video != nil
            {
                multipartFormData.append(video!, withName: "video" , fileName: "video" + ".mp4", mimeType: "video/mp4")

            }
            
            for (key, value) in param {
                print("\(value)".data(using: .utf8)!)
                if key == "images" || key == "video"
                {
                    print("we skip file cause already added")
                }
                else{
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
            
        },to : request.url!.absoluteString , usingThreshold: UInt64.init() , method: request.method!, headers: request.headers)
        
            .responseJSON(completionHandler: { (response) in
                print(response.data)
                print(response.result)
                
                
            })
            .responseDecodable(of: BaseResponse<T>.self) { (response) in
                
                switch response.result {
                    
                case .success(let res):
                    
                    if res.code == 200 {
                        print(res.data)
                        print(res.message)
                        completion(.success(data: res.data , code : res.code , message: res.message ))
                        
                    } else {
                        
                        let statusCode = res.code
                        
                        if let reason = GetFailureReason(rawValue: statusCode) {
                            
                            let appError = AppError(reason: reason, message: res.message)
                            
                            completion(.failure(appError))
                            
                        } else {
                            
                            completion(.failure(AppError(reason: nil , message: res.message)))
                        }
                        
                    }
                case .failure(_):
                    
                    if let statusCode = response.response?.statusCode,
                       let reason = GetFailureReason(rawValue: statusCode) {
                        
                        let appError = AppError(reason: reason, message: "unknown error")
                        
                        completion(.failure(appError))
                        
                    } else {
                        
                        let response = try? JSONDecoder().decode(BaseResponse<EmptyResponse>.self, from: response.data!)
                        
                        if let code = response?.code {
                            
                            if code != 200 {
                                
                                if  let reason = GetFailureReason(rawValue: code) {
                                    
                                    let appError = AppError(reason: reason, message: response?.message)
                                    
                                    completion(.failure(appError))
                                    
                                }else{
                                    completion(.failure(AppError(reason: nil , message: response?.message )))
                                }
                            }
                            else{
                                completion(.failure(AppError(reason: nil , message: response?.message )))
                            }
                        }
                        
                    }
                }
            }
    }
}

extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}
