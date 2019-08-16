//
//  AppDelegate.swift
//  maps
//
//  Created by Денис Наумов on 05/08/2019.
//  Copyright © 2019 Денис Наумов. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        initView()
        
        return true
    }

    private func initView() {
        let galleryModule = GalleryRouter.createModule()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = galleryModule
        self.window?.makeKeyAndVisible()
    }
}
