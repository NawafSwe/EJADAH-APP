//
//  FastRewindButtonView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import SwiftUI

struct FastRewindOrForwardButtonView: View {
    var text:String
    var body: some View {
        Image(text)
            .resizable()
            .frame(width:39 , height: 30)
            .accessibility(label: Text("زر تقديم او تاخير المقطع الصوتي"))
    }
}

struct FastRewindButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FastRewindOrForwardButtonView(text: IconsCollection.fastRewind)
    }
}
