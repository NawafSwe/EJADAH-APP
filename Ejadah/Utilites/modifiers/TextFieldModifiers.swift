//
//  TextFieldModifiers.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 11/05/2021.
//

import Foundation
import SwiftUI

struct TextFieldModifiers:ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
    }
    
}
