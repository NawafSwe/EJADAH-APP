//
//  OneButtonHeaderView.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 09/04/2021.
//

import SwiftUI

struct OneButtonHeaderView: View {
    let title:String
    let rightCallBack:()->Void
    let rightIcon:String
    var body: some View {
        HStack(alignment:.center){
            
            Spacer().frame(width:UIScreen.width / 5)
            Text(title)
                
                .padding(.horizontal)
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 20, type: K.TajwalFonts.bold, fixedSizeHr: true, fixedSizeVr: false, alignment: .center))
                .padding(.horizontal)
                .padding(.top, 12)
                .accessibility(label: Text(title))
            Spacer()
               
            
            
            Button(action: rightCallBack){
                Image(rightIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }
            .padding(.trailing)
            
       

        }
        .padding(.top)
        .padding(.horizontal)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8)
        .background(Color.headerColor)
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}

struct OneButtonHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OneButtonHeaderView(title: "عربي", rightCallBack: K.callBack, rightIcon: IconsCollection.rightArrow)
    }
}
