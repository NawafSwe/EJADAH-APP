//
//  HeaderView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 04/01/2021.
//

import SwiftUI

struct HeaderView: View {
    let title:String
    // let size:CGFloat
    var body: some View {
        ZStack {
            Text(title)
                .padding(.top)
                .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8 , alignment: .center)
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 24, type: K.TajwalFonts.bold, fixedSizeHr: false, fixedSizeVr: true, alignment: .center))
                .background(Color.headerColor)
                .accessibility(label: AccessibilitiesDescription.headerCategoryTitle.label)
        }
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "الرئيسية")
    }
}


