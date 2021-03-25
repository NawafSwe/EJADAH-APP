//
//  TextModifiers.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 05/02/2021.
//

import Foundation
import SwiftUI


struct TextModifiers:ViewModifier{
    let size:CGFloat
    let type:String
    let fixedSizeHr:Bool
    let fixedSizeVr:Bool
    let alignment: TextAlignment
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(type, size: size))
            .multilineTextAlignment(alignment)
            .fixedSize(horizontal: fixedSizeHr, vertical: fixedSizeVr)
            .padding()
        
    }
}
