//
//  Photo.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/18.
//

import Foundation

struct Photo : Codable {
  var thumbnail : String
  var username : String
  var likesCount : Int
  var createdAt : String
}
