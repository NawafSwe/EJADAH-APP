//
//  CustomNavigationView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 02/02/2021.
//
import Foundation
import SwiftUI
/// destination: Used to pass a destination view to our custom navigation view. Give it an EmptyView() when there is no destination view.
/// isRoot: A boolean value used to establish the root view. We will use it to control the opacity of the back arrow button.
//// isLast: A boolean value used to determine the last view. For this tutorial, we will use this value to control the opacity of our navigation link button.
////color: To customize the navigation bar color.
/// content: Provides closure for passing child views to our custom navigation view.
/// active: A state variable used to control the navigation link.
/// mode: An environment variable handler to dismiss views.
struct CustomNavigationView<Content:View, Destination>: View {
    let destination:Destination
    let isRoot:Bool
    let isLast:Bool
    let color :Color
    let content:Content
    @State var active = false
    @Environment (\.presentationMode) var mode : Binding<PresentationMode>
    
    init(destination:Destination , isRoot:Bool, isLast:Bool , color:Color, @ViewBuilder content:()-> Content){
        self.destination = destination
        self.isRoot = isRoot
        self.isLast = isLast
        self.color = color
        self.content = content()
    }
    var body: some View {
       // some view
        NavigationView {
                VStack {
                    self.content
                        .background(color.opacity(0.3))
                        
                }
            
            .navigationBarHidden(true)
        }
    }
    }


struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(destination: EmptyView() , isRoot: true, isLast: true, color: Color.mainBackground) {
            HeaderView(title: "Categories")
        }
    }
}
