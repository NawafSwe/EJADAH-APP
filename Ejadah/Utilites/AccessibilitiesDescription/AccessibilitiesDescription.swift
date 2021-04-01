//
//  AccessibilitiesDescription.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 09/01/2021.
//

import Foundation
import SwiftUI
//MARK:- AccessibilityDescription
/// making accessibility object to communicate with users
struct AccessibilityDescription : Identifiable{
    var id = UUID()
    /// explaining what is the element is
    var label:Text
    /// explaining what will happen after performing this task
    var hint:Text
    /// value of toggle buttons 0 false , 1 true
    var value:Int
    
}
//MARK:- AccessibilitiesDescription
/// holding static accessibility data that can be used anywhere in the app
struct AccessibilitiesDescription{
       static let headerCategoryTitle = AccessibilityDescription(label: Text("الرئيسية"), hint: Text(""), value: 0)
        static let backTrack = AccessibilityDescription(label: Text("الرجوع"), hint: Text(""), value: 0)
       static let playButton = AccessibilityDescription(label: Text("تشغيل الشرح"), hint: Text("سيتم بدء الشرح الصوتي"), value: 0)
       static let lineProgress = AccessibilityDescription(label: Text("تقديم او تاخير الشرح"), hint:Text("يمكنك التحريك يمينا وشمالا للتحكم"), value: 0)
       static let shareButton = AccessibilityDescription(label: Text(" المشاركة للشرح"), hint: Text("سيتم مشاركه الشرح على"), value: 0)
    }
