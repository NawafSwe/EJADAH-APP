//
//  Color+Ext.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import SwiftUI
//MARK:- Color extension
// color extension helper to make it easier to add colors and avoid siblings mistakes.
extension Color {
    static let headerColor        = Color("headerColor")
    static let boxColor           = Color("playBoxColor")
    static let tabColor           = Color("TabColor")
    static let durationBackground = Color("durationBG")
    static let borders            = Color("borders")
    static let mainBackground     = Color("mainBG")
    static let mainText           = Color("mainText")
    static let durationText       = Color("durationText")
    static let divider            = Color("divider")
    static let slider             = Color("silder")

}
//MARK:- Extension for UIKit Color
extension UIColor{
    static let tabBackground = UIColor(named:"headerColor")
    static let unSelectedTap = UIColor(named: "unSelectedTap")

}
