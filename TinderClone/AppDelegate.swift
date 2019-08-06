//
//  AppDelegate.swift
//  TinderClone
//
//  Created by 국윤수 on 23/06/2019.
//  Copyright © 2019 국윤수. All rights reserved.
//

import UIKit

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = HomeController()

    return true
  }

}

