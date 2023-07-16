//
//  AppDelegate.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//

import UIKit
import Swinject
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    static let container = Container()
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
      
      AppDelegate.container.registerDependencies()

      let navController = UINavigationController()
      navController.setNavigationBarHidden(true, animated: false)
      MainCoordinator.shared = MainCoordinator(navigationController: navController)
      MainCoordinator.shared?.pushPlayersPage()
    
      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = navController
      window?.makeKeyAndVisible()
      
    return true
  }




}

