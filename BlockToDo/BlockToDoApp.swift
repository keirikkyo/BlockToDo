//
//  BlockToDoApp.swift
//  BlockToDo
//
//  Created by 吉江恵 on 2024/05/27.
//

import SwiftUI
import FamilyControls
import ManagedSettings

@main
struct YourApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ManagedSettingsStore(named: ManagedSettingsStore.Name(rawValue: "RestrictionStore") ).shield.applications = .none // 初期化
        
        return true
    }
}

