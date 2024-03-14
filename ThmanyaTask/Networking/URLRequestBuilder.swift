//
//  URLRequestBuilder.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation
import Alamofire
import Combine

//MARK:- URL Request Building Protocol
protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: String { get }
    
    var mainURL: URL { get }
    
    var requestURL: URL{ get }
    
    var path: String { get }
    
    var headers: HTTPHeaders { get }
    
    var parameters: Parameters? { get }
    
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    var analyticsName: String { get }
    
    func Request<T: Codable>(model: T.Type) async throws -> T
    
}


extension URLRequestBuilder {
    
    var baseURL: String {
        return Environment.current()?.rawValue ?? ServerEndpointsPath.baseURL.rawValue
    }
    
    var mainURL: URL {
        /*Forced Typecast is safe here because your baseURL must be valid or the app will crash with the First API Request
         and navigate to this line of code before even launch
         */
        return URL(string: baseURL)!
    }
    
    var requestURL: URL {
        /*Forced Typecast is safe here because if mainURL is valid requestURL is going to be valid even if path is empty
         */
        let urlStr = mainURL.absoluteString + path
        return URL(string: urlStr)!
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        case .delete:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    var headers: HTTPHeaders {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        return HTTPHeaders(headers)
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach{request.addValue($0.value, forHTTPHeaderField: $0.name)}
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK:- API Request Function
    func Request<T: Codable>(model: T.Type) async throws -> T {
        let manager = AF
        manager.sessionConfiguration.timeoutIntervalForRequest = 60
        let request =  manager.request(self).serializingDecodable(model.self, automaticallyCancelling: true)
        await request.interceptResuest("\(requestURL)", parameters)
        let value = try await request.value
        return value
    }
}
