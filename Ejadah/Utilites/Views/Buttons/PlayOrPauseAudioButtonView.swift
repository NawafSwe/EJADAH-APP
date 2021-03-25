//
//  PlayAudioButtonView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import SwiftUI

struct PlayOrPauseAudioButtonView: View {
    var text:String
    var body: some View {
        Image(text)
            .resizable()
            .frame(width: 102, height: 102, alignment: .center)
            .accessibility(label: Text("زر ايقاف وتشغيل الصوت"))
    }
}

struct PlayAudioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayOrPauseAudioButtonView(text: IconsCollection.playAudio)
    }
}
