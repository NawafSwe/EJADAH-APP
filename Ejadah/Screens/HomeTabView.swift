//
//  HomeTabView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 25/01/2021.
//

import SwiftUI

struct HomeTabView: View {
    
    init(){
        UITabBar.appearance().barTintColor = UIColor.tabBackground
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = UIColor.unSelectedTap
    }
    
    var body: some View {
        
        TabView {
            CategoryListView().tabItem {
                Image(systemName: SFIcons.homeTab)
                    .resizable()
                    .modifier(TabIconsModifiers())
                Text("الرئيسية")

            }
        
            AboutUsView().tabItem {
                Image(systemName: SFIcons.bulbTab)
                    .resizable()
                    .modifier(TabIconsModifiers())
                Text("عن إجادة")
            }
            
            AdminView().tabItem{
                Image(IconsCollection.user)
                    .resizable()
                    .modifier(TabIconsModifiers())
                Text("المشرف")
            }
        }
        .accentColor(.tabColor)
        .animation(.easeIn, value: 0.3)
        .animation(nil)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
            .colorScheme(.dark)
    }
}

//MARK:- TabIcons modifiers
struct TabIconsModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20, alignment: .center)
    }
}
