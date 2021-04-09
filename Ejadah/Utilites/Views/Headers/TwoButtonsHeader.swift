//
//  TwoButtonsHeader.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 09/04/2021.
//

import SwiftUI

struct TwoButtonsHeader: View {
    let title:String
    let leftCallBack: ()->Void
    let rightCallBack:()->Void
    let leftIcon:String
    let rightIcon:String
    
    var body:some View{
        HStack{
            Button(action: leftCallBack ){
                Image(leftIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                
            }
            .padding(.leading)
            Spacer()
            Text(title)
                
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 20, type: K.TajwalFonts.bold, fixedSizeHr: true, fixedSizeVr: false, alignment: .center))
                .padding(.horizontal)
            Spacer()
            Button(action:rightCallBack){
                Image(rightIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                
            }
            .padding(.trailing)
            
        }
        .padding(.top)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8)
        .background(Color.headerColor)
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}

//struct TwoButtonsHeader_Previews: PreviewProvider {
//    static var previews: some View
//    {
//        TwoButtonsHeader(title: "Header", leftCallBack: K.callBack(), rightCallBack: K.callBack(), leftIcon: IconsCollection.add, rightIcon: IconsCollection.logout)
//    }
//}
