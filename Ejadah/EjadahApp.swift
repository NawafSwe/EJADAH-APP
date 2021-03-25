//
//  ios_AccessibilityApp.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 30/01/2021.
//

import SwiftUI
import Firebase
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        return true
    }
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink){
        guard let url = dynamicLink.url else {
            print("wired there is no url")
            return
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let _ = components.queryItems else { return }
        
    }
    /// for dynamic urls
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        var linkHandled = false
        // checking if there is incoming urls
        if let incomingUrl = userActivity.webpageURL{
            print(incomingUrl.absoluteURL)
            DynamicLinks.dynamicLinks().handleUniversalLink(incomingUrl){ (link , error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let dynamicLink = link{
                    self.handleIncomingDynamicLink(dynamicLink)
                    linkHandled = true
                }
            }
        }
        if linkHandled{
            return true
            
        } else {
            return false
            
        }
    }
    
    /// opening on dynamic links
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url){
            self.handleIncomingDynamicLink(dynamicLink)
            return true
        }else {
            return false
        }
    }
    
}

@main
struct EjadahApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            HomeTabView()
        }
    }
}
