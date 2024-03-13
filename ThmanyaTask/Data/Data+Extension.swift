//
//  Data+Extension.swift
//  TmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation
import Alamofire

extension Data {
    
    static func convertToJSON(_ objc: Any) -> Data? {
        var data: Data?
        if let jsonString = objc as? String {
            let result = jsonString.data(using: .utf8, allowLossyConversion: false)
            data = result
        } else if let jsonArrayOfDictionary = objc as? [[String: AnyObject]] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonArrayOfDictionary, options: .prettyPrinted)
                data = result
            } catch let error  {
                debugPrint("[ConvertToData] failed to convert to Array of Dictionary\nError \(error)")
                data = nil
            }
        } else if let jsonDictionary = objc as? [String: AnyObject] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
                data = result
            } catch let error {
                debugPrint("[ConvertToData] failed to convert to Dictionary\nError \(error)")
                data = nil
            }
        }
        return data
    }
}

extension AFDataResponse {
    
    func interceptResuest(_ url: String, _ params: Parameters?){
        print("==================[URLRequestBuilder]==================\n")
        print("[URLRequestBuilder] ===(\(url))=== \n")
        print("[URLRequestBuilder] parameters =======> \(params ?? [:]) \n")
        print("[URLRequestBuilder] Header =====> \(request?.allHTTPHeaderFields ?? [:]) \n")
        print(response?.url?.absoluteURL ?? "")
        print("[URLRequestBuilder]statusCode =====> \(response?.statusCode ?? 00000) \n")
        print("[URLRequestBuilder] result ======> ", try? result.get())
        print("==================[URLRequestBuilder]==================\n")
    }
}
