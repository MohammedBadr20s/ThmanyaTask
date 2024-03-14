//
//  Data+Extension.swift
//  ThmanyaTask
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

extension DataTask {
    
    func interceptResuest(_ url: String, _ params: Parameters?) async {
        let response = await response
        print("==================[URLRequestBuilder]==================\n")
        print("[URLRequestBuilder] ===(\(url))=== \n")
        print("[URLRequestBuilder] parameters =======> \(params ?? [:]) \n")
        print("[URLRequestBuilder] Header =====> \(response.request?.allHTTPHeaderFields ?? [:]) \n")
        print(response.request?.url?.absoluteURL ?? "")
        print("[URLRequestBuilder]statusCode =====> \(response.response?.statusCode ?? 00000) \n")
        switch response.result {
        case .success(_):
            if let data = response.data {
                print("[URLRequestBuilder] result ======> \n", String(data: data, encoding: String.Encoding.utf8) ?? "")
            }
        case .failure(let error):
            print("[URLRequestBuilder] result ======> ", error)

        }
        print("==================[URLRequestBuilder]==================\n")
    }
}
