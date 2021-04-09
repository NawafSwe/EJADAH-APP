//
//  MainHeaderView.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 09/04/2021.
//

import SwiftUI

struct MainHeaderView: View {
    let title:String
    var body: some View {
        HStack{
            Spacer()
            Text("\(title)")
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 20, type: K.TajwalFonts.bold, fixedSizeHr: true, fixedSizeVr: false, alignment: .center))
                .padding(.top, 12)
                .accessibility(label: Text(title))
            Spacer()
        }
        .padding(.top)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8)
        .background(Color.headerColor)
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(title:"header")
    }
}
