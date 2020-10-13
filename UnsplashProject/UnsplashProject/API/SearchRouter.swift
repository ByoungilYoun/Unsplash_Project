//
//  SearchRouter.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/14.
//

import Foundation
import Alamofire

// 검색 관련 api
enum SearchRouter : URLRequestConvertible {
  
  case searchPhotos(term : String)
  case searchUsers(term : String)
  
  var baseURL : URL {
    return URL(string: API.Base_URL + "search/")!
  }
  
  var method : HTTPMethod {
    switch self {
    case .searchPhotos, .searchUsers:
      return .get
    }
  }
  
  var endPoint : String {
    switch self {
    case .searchPhotos:
      return "photos/"
    case .searchUsers:
      return "users/"
    }
  }
  
  var parameters : [String : String] {
    switch self {
    case let .searchPhotos(term), let .searchUsers(term):
      return ["query" : term]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
  
    let url = baseURL.appendingPathComponent(endPoint)
    
    print("SearchRouter - asURLRequest()")
    
    var request = URLRequest(url: url)
    
    request.method = method
    
    request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
    
//    switch self {
//    case let .searchPhotos(term):
//      request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//    case let .searchUsers(term):
//      request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//    }
    
    return request
  }
}
