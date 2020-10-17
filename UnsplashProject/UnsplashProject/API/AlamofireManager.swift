//
//  AlamofireManager.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/13.
//

import Foundation
import Alamofire
import SwiftyJSON

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
  
  func getPhotos(searchTerm userInput : String, completion : @escaping (Result<[Photo], MyError>) -> Void) {
    print("AlamofireManager - getPhotos 호출 \(userInput)")
    self.session.request(SearchRouter.searchPhotos(term: userInput)).validate(statusCode: 200..<401).responseJSON(completionHandler: { response in
      
      guard let responseValue = response.value else {return}
      
      let responseJson = JSON(responseValue)
      
      let jsonArray = responseJson["results"]
      
      var photos = [Photo]()
      
      print("jsonArray.size : \(jsonArray.count)")
      
      for (index, subJson) : (String, JSON) in jsonArray {
        print("index : \(index) , subJson : \(subJson)")
        
        //데이터 파싱
        let thubnail = subJson["urls"]["thumb"].string ?? ""
        let username = subJson["user"]["username"].string ?? ""
        let likesCount = subJson["likes"].intValue
        let createdAt = subJson["created_at"].string ?? ""
        
        
        
        let photoItem = Photo(thumbnail: thubnail, username: username, likesCount: likesCount, createdAt: createdAt)
        
        //배열에 넣고
        photos.append(photoItem)
      }
      
      if photos.count > 0 {
        completion(.success(photos)) // 사진이 하나라도 있으면 success 로 photos 를 보내준다.
      } else {
        completion(.failure(.noContents))
      }
    })

  }
}
