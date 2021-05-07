//
//  AlertItem.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 11/01/2021.
//

import Foundation
import SwiftUI
 //MARK:- AlertItem
 /// making alert objects for identifying actions required
struct AlertItem : Identifiable{
    var id = UUID()
    var title:Text
    var message:Text
    var dismissButton: Alert.Button
    var action : ( ()->Void )?
}

 

