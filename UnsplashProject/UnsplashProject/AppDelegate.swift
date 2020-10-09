//
//  AppDelegate.swift
//  UnsplashProject
//
//  Created by 윤병일 on 2020/10/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = ViewController()
    window?.backgroundColor = .systemBackground
    window?.makeKeyAndVisible()
    return true
  }
}

