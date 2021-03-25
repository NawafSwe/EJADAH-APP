//
//  SplashView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 13/02/2021.
//

import SwiftUI

struct SplashView: View {
    let name = Text("إجادة")
    var body: some View {
        ZStack{
            Color.boxColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 64) {
                Image("EjadaLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 220, alignment: .center)
                    .accessibility(label: Text("شعار إجادة"))
                
                name
                    .font(Font.custom(K.TajwalFonts.bold, size: 36))
                    .foregroundColor(Color.durationBackground)
                    .accessibility(label: name)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
