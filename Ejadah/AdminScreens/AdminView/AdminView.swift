//
//  AdminView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 19/02/2021.
//

import SwiftUI

struct AdminView: View {
    let headerTitle = "المشرف"
    let addCategoryTitle = "إضافة شرح"
    let editContentTitle = "تعديل على المحتويات"
    let logoutTitle = "تسجيل الخروج"
    var body: some View {
        ZStack{
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
                HeaderView(title: headerTitle)
                
                Button(action:{}){
                MainButtonView(title: addCategoryTitle, width: UIScreen.width / 2 , height: UIScreen.height / 4 * 0.25)
                }
                
                Button(action:{}){
                    MainButtonView(title: editContentTitle, width: UIScreen.width / 2 , height: UIScreen.height / 4 * 0.25)
                }
                
                Button(action:{}){
                    MainButtonView(title: logoutTitle, color: Color.mainText ,width: UIScreen.width / 3 , height: UIScreen.height / 4 * 0.25)
                }
                Spacer()
            }
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
