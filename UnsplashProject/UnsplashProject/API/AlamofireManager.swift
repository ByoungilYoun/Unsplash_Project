//
//  AlamofireManager.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/13.
//

import Foundation
import Alamofire

final class AlamofireManager {
  // 싱글톤 적용
  static let shared = AlamofireManager()
  
  // 인터셉터 - 헤더 등을 추가 가능
  let interceptors = Interceptor(interceptors:
                                  [
                                    BaseInterceptor()
                                  ])
  
  // 로거 설정 (여러개 넣을수 있다)
  let monitors = [Logger()]
  
  // 세션 설정
  var session : Session
  
  private init() {
    session = Session(interceptor : interceptors, eventMonitors: monitors)
  }
}
