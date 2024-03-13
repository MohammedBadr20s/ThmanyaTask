//
//  URLRequestBuilder.swift
//  TmanyaTask
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
    
    func Request<T: BaseModelProtocol>(model: T.Type) -> Observable<T>
    
    func Request<T: BaseModelProtocol>(model: T.Type, result: @escaping (_ result: T) -> Void, onError: @escaping (_ error: Error) -> Void)
    
    func handleError<T: BaseModelProtocol>(apiError: ApiError?, data: Any?, observer: AnyObserver<T>)
    
    func handleError(apiError: ApiError?, data: Any?, onError: @escaping (_ error: Error) -> Void)
}


extension URLRequestBuilder {
    
    var baseURL: String {
        return Environment.current()?.rawValue ?? ServerPath.baseURL.rawValue
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
        var headers = [
            "Content-Type": "application/json",
//            "Accept-Language": LocalizationHelper.getCurrentLanguage(),
            "Accept": "application/json",
        ]
        if let token = Keychain.userToken {
            headers["auth-token"] = "Bearer \(token)"
        }
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
    func Request<T: BaseModelProtocol>(model: T.Type) -> Observable<T> {
        return Observable.create { (observer: AnyObserver<T>) -> Disposable in
            let manager = AF
            manager.sessionConfiguration.timeoutIntervalForRequest = 60
            manager.request(self).responseJSON { (response: AFDataResponse<Any>) in
                response.interceptResuest("\(self.requestURL)", self.parameters)
                
                let resEnum = ResponseHandler.shared.handleResponse(response, model: model)
                
                switch resEnum {
                case .failure(let error, let data):
                    return handleError(apiError: error, data: data, observer: observer)
                case .success(let value):
                    if let model = value as? T {
                        observer.onNext(model)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func Request<T: BaseModelProtocol>(model: T.Type, result: @escaping (_ result: T) -> Void, onError: @escaping (_ error: Error) -> Void) {
        let manager = AF
        manager.sessionConfiguration.timeoutIntervalForRequest = 60
        manager.request(self).responseJSON { (response: AFDataResponse<Any>) in
            response.interceptResuest("\(self.requestURL)", self.parameters)
            
            let resEnum = ResponseHandler.shared.handleResponse(response, model: model)
            
            switch resEnum {
            case .failure(let error, let data):
                return handleError(apiError: error, data: data, onError: onError)
            case .success(let value):
                if let model = value as? T {
                    result(model)
                }
            }
        }
    }
    
    //MARK:- Handle Error comes from Request Function
    func handleError<T: BaseModelProtocol>(apiError: ApiError?, data: Any?, observer: AnyObserver<T>) {
        if let error = data as? BaseErrorModel {
            observer.onError(error)
        } else if let apiError = apiError {
            observer.onError(BaseErrorModel(statusCode: apiError.rawValue, errors: [DiarkoErrorResponse(msg: apiError.title)], isSuccess: false))
        } else if let error = data as? [BaseErrorModel] {
            let defaultError = BaseErrorModel(statusCode: apiError?.rawValue, errors: [DiarkoErrorResponse(msg: apiError?.title)], isSuccess: false)
            observer.onError(error.first ?? defaultError)
        }else {
            let defaultError = BaseErrorModel(statusCode: apiError?.rawValue, errors: [DiarkoErrorResponse(msg: "404 Not Found")], isSuccess: false)
            observer.onError(defaultError)
        }
    }
    
    func handleError(apiError: ApiError?, data: Any?, onError: @escaping (_ error: Error) -> Void) {
        if let error = data as? BaseErrorModel {
            onError(error)
        } else if let apiError = apiError {
            onError(BaseErrorModel(statusCode: apiError.rawValue, errors: [DiarkoErrorResponse(msg: apiError.title)], isSuccess: false))

        } else if let error = data as? [BaseErrorModel] {
            let defaultError = BaseErrorModel(statusCode: apiError?.rawValue, errors: [DiarkoErrorResponse(msg: apiError?.title)], isSuccess: false)
            onError(error.first ?? defaultError)
        }
    }
}
