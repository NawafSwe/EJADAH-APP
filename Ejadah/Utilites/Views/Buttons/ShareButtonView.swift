//
//  ShareButtonView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import SwiftUI

struct ShareButtonView: View {
    var body: some View {
        Image(IconsCollection.share)
            .resizable()
            .frame(width: 41 , height: 41)
            .accessibility(label: Text("زر مشاركه الشرح"))
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView()
    }
}
