//
//  AppDelegate.swift
//  RxSwiftExamples
//
//  Created by Oleksandr  on 23/02/2018.
//  Copyright © 2018 Oleksandr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        RxHelper.run()
        return true
    }
}
