//
//  Logger.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/13.
//

import Foundation
import Alamofire

final class Logger : EventMonitor {
  
  let queue = DispatchQueue(label: "Logger")
  
  func requestDidResume(_ request: Request) {
    print("Logger - requestDidResume()")
    debugPrint(request)
  }
  
  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    print("Logger - request.didParseResponse()")
    debugPrint(response)
  }
}
