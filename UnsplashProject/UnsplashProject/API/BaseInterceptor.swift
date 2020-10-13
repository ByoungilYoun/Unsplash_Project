//
//  BaseInterceptor.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/13.
//

import Foundation
import Alamofire

class BaseInterceptor : RequestInterceptor {

  // request 가 호출될때 같이 호출된다.
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    print("BaseInterceptor - adapt() called")
    
    var request = urlRequest
    request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
    
    // 공통 파라미터 추가
    var dictionary = [String : String]()
    dictionary.updateValue(API.Client_ID, forKey: "client_id")
    
    do {
      // dictionary를 파라미터 추가
      request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
    } catch {
        print(error)
    }
    
    completion(.success(request))
  }
  
  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    print("BaseInterceptor - retry() called")
    // api 호출을 다시 호출할거냐 
    completion(.doNotRetry)
  }
}
