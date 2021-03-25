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
       static let playButton = AccessibilityDescription(label: Text("تشغيل الشرح"), hint: Text("عند الضغط هذا الزر سيتم بدء الشرح الصوتي"), value: 0)
       static let lineProgress = AccessibilityDescription(label: Text("يمكنك التحكم بالشرح تقديم أو تأخير"), hint: Text(" يمكن التحكم بتحريك يمين أو يسار"), value: 0)
       static let shareButton = AccessibilityDescription(label: Text("زر المشاركة للشرح"), hint: Text("عند ضغظ هذا الزر سوف يتم فتح قائمه العناصر لمشاركه الشرح على تطبيقات التواصل"), value: 0)
    }
