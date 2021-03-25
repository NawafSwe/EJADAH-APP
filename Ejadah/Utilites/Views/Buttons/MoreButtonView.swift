//
//  MoreButtonView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 01/03/2021.
//

import SwiftUI

struct MoreButtonView: View {
    var body: some View {
        Image(IconsCollection.more)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.width / 5 * 0.3, height: UIScreen.height / 5 * 0.05, alignment: .center)
            .padding()
    }
}

struct MoreButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MoreButtonView()
    }
}
