//
//  UIScreen+Ext.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 26/01/2021.
//

import Foundation
import SwiftUI

 //MARK:- extension UIScreen 
extension UIScreen{
    /// extracting values of screen `width`, `height` to be accessible everywhere using short code
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}
