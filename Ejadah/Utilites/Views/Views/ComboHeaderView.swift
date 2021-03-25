//
//  ComboHeaderView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 24/02/2021.
//

import SwiftUI

struct ComboHeaderView: View {
    let title:String
    var leftCallBack: () -> (Void)?
    var rightCallBack: () -> (Void)?
    let leftButtonTitle:String?
    let leftButtonIcon:String?
    let rightButtonIcon:String?
    
    var body: some View {
        let spacing : CGFloat  = (self.leftButtonIcon != nil && self.rightButtonIcon != nil) ? 0 : -40
       return HStack(alignment:.center , spacing: spacing ){
            // if right button exits or button title not exits
            if self.rightButtonIcon != nil || self.leftButtonTitle == nil { Spacer() }
        
            // left button
            if let leftButtonTitle = self.leftButtonTitle  , let leftButtonIcon = self.leftButtonIcon{
                Button(action: { leftCallBack() }  ){
                    VStack(alignment: .center){
                Image(leftButtonIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                    .padding(.top, 12)
                        
                        Text(leftButtonTitle)
                            .font(Font.custom(K.TajwalFonts.regular, size: 12))
                            .foregroundColor(.mainText)
                            .frame(alignment: .center)
                       
                  }
                    .padding(.top , 5)

                }
               
            }
        
            // title of the header
            Spacer()
            Text(title)
                    .foregroundColor(.mainText)
                    .modifier(TextModifiers(size: 20, type: K.TajwalFonts.bold, fixedSizeHr: true, fixedSizeVr: false, alignment: .center))
                    .padding(.horizontal)
                .padding(.top, 12)
                    .accessibility(label: AccessibilitiesDescription.headerCategoryTitle.label)
            Spacer()
            // if there is no elements
            if self.leftButtonIcon == nil && self.rightButtonIcon == nil { Spacer() }
            
              
        // right button
            if let rightButton = self.rightButtonIcon{
               Spacer()
                Button(action:{rightCallBack() }){
                    Image(rightButton)
                    .resizable()
                        .frame(width: 32, height: 32, alignment: .center)
                        .padding(.top, 12)
                    
                }

                .padding(.trailing, UIScreen.width / 2 * 0.09)

            }
            
            
        }
        .padding(.top)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8)
        .background(Color.headerColor)
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ComboHeaderView_Previews: PreviewProvider {
    static var previews: some View {
     ComboHeaderView(title:"combo view", leftCallBack: K.callBack, rightCallBack: K.callBack, leftButtonTitle: "left button",leftButtonIcon: IconsCollection.add, rightButtonIcon: IconsCollection.rightArrow)
      // ComboHeaderView(title: "Combo", rightButtonIcon: IconsCollection.rightArrow, rightCallBack: K.callBack)
        //ComboHeaderView(title: "Combo view")
    }
}
 //MARK:- extension ComboHeaderView
extension ComboHeaderView{
     //MARK:- initialises
    
    // Having buttons both sides
    init(title:String ,rightButtonIcon:String?, rightCallBack : @escaping ()-> (Void)? , leftButtonIcon:String?, leftButtonTitle:String? , leftCallBack: @escaping ()->(Void)? ){
        self.title = title
        self.rightCallBack = rightCallBack
        self.leftButtonIcon = leftButtonIcon
        self.leftCallBack = leftCallBack
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonIcon = rightButtonIcon
    }
    
    // having only title
    init(title:String){
        self.title = title
        self.rightCallBack = K.callBack
        self.leftButtonIcon = nil
        self.leftCallBack = K.callBack
        self.leftButtonTitle = nil
        self.rightButtonIcon = nil
    }
    
    // having only right button for dismiss
    init(title:String , rightButtonIcon:String? , rightCallBack: @escaping ()->(Void)? ){
        self.title = title
        self.rightButtonIcon = rightButtonIcon
        self.rightCallBack = rightCallBack
        self.leftButtonTitle = nil
        self.leftCallBack = K.callBack
        self.leftButtonIcon = nil
    }
    
    // having only left side
    init(title:String , leftButtonTitle:String? ,leftButtonIcon:String? ,leftCallBack: @escaping ()->(Void)? ){
        self.title = title
        self.rightButtonIcon = nil
        self.rightCallBack = K.callBack
        self.leftButtonTitle = leftButtonTitle
        self.leftCallBack = leftCallBack
        self.leftButtonIcon = leftButtonIcon
    }
}
