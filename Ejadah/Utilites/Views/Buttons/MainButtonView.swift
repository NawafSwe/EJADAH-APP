//
//  MainButtonView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 26/01/2021.
//

import SwiftUI

struct MainButtonView: View {
    let title:String
    let width:CGFloat?
    let height:CGFloat?
    let color: Color?
    let icon:String?
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.durationText)
                .font(Font.custom(K.TajwalFonts.regular, size: 14))
                .frame(width: width != nil ? width :  126, height: height != nil ? height : 36, alignment: .center)
                .background(color != nil ? color : Color.durationBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top)
                .accessibility(label: Text("\(title)"))
            
            if icon != nil {
                Image(icon!)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            }
        }
            
    }
}
struct MainButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView(title: "click me")
    }
}

 //MARK:- extension on MainButtonView
extension MainButtonView{
    //MARK:- initialises
   init(title:String){
       self.title = title
       self.width = nil
       self.height = nil
       self.color = nil
       self.icon = nil
   }
   init(title:String, width:CGFloat? , height:CGFloat? ){
       self.title = title
       self.width = width
       self.height = height
       self.color = nil
       self.icon = nil
   }
   init(title:String, width:CGFloat?){
       self.title = title
       self.width = width
       self.height = nil
       self.color = nil
       self.icon = nil
   }
   init(title:String, height:CGFloat?){
       self.title = title
       self.width = nil
       self.height = height
       self.color = nil
       self.icon = nil
   }
    
    init(title:String , color: Color? , width:CGFloat? , height:CGFloat?){
        self.title = title
        self.width = width
        self.height = height
        self.color = color
        self.icon = nil
    }
    init(title:String, icon:String? , color:Color?, width:CGFloat? , height:CGFloat?){
        self.title = title
        self.icon = icon
        self.width = width
        self.height = height
        self.color = color
    }
}
