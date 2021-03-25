//
//  RightArrowView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 04/01/2021.
//

import SwiftUI

struct RightArrowButtonView: View {
    var body: some View {
        Image(IconsCollection.rightArrow)
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .accessibility(label: Text("زر الرجوع للخلف"))
    }
}

struct RightArrowView_Previews: PreviewProvider {
    static var previews: some View {
        RightArrowButtonView()
    }
}
