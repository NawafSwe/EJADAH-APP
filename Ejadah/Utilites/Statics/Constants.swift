//
//  Constants.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 26/01/2021.
//

import Foundation
import SwiftUI
struct K {
    //MARK:- Variables
    static let AXENDA_ACCOUNT = URL(string:"https://twitter.com/axendateam")!
    // MARK:- Preview_Devices
    /// to avoid typos and saving time 🥶
    // constructing share link vars
    // app image is already uploaded in fire storage
    static let APP_IMAGE = URL(string: "https://firebasestorage.googleapis.com/v0/b/axe-ejadah.appspot.com/o/MainIcon.jpg?alt=media&token=7db50d1e-c694-41e1-aad5-b9ea5ea4bc4c")!
    static let APP_ID = "1551553821"
    static let HOST_NAME = "ejadah.page.link"
    static let TRACKS_PATH = "/tracks"
    static let PROTOCOL = "https"
    static let DOMAIN_URIPREFIX = "\(PROTOCOL)://\(HOST_NAME)"
    static func makeQuery(with id: String)-> URLQueryItem{
        let trackQuery = URLQueryItem(name: "id", value: id)
        return trackQuery
    }
    
    enum Devices{
        static let iPhoneSE       =   PreviewDevice(rawValue:"iPhone SE (2nd generation)")
        static let iPhone8        =   PreviewDevice(rawValue:"iPhone8")
        static let iPhoneX        =   PreviewDevice(rawValue:"iPhone X")
        static let iPhoneXS       =   PreviewDevice(rawValue: "iPhone XS")
        static let iPhone12Mini   =   PreviewDevice(rawValue:"iPhone 12 mini")
        static let iPhone12       =   PreviewDevice(rawValue:"iPhone 12")
        static let iPhone12ProMax =   PreviewDevice(rawValue:"iPhone 12 Pro Max")
        static let iPod           =   PreviewDevice(rawValue:"iPod touch (7th generation)")
    }
    // MARK:- FirebaseCollections
    enum FirebaseCollections{
        static let category = "Categories"
        static let track = "Tracks"
    }
    //MARK:- Fonts
    enum TajwalFonts{
        static let extraBold = "Tajawal-ExtraBold"
        static let light = "Tajawal-Light"
        static let bold = "Tajawal-Bold"
        static let extraLight = "Tajawal-ExtraLight"
        static let regular = "Tajawal-Regular"
        static let medium = "Tajawal-Medium"
        static let black = "Tajawal-Black"
    }
    
    //MARK:- Sizes
    enum Sizes {
        static let scrollVPadding: CGFloat = 32
        static let scrollHPadding: CGFloat = 24
        static let scrollVSpacing: CGFloat = 24
    }
    
    //MARK:- empty callBack
    static func callBack(){return}
    
    //MARK:- Files names
    enum Files{
        static let uploadLoading = "uploadLoading"
    }
    
    //MARK:- dismissKeyboard
    static func dismissKeyBoard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
