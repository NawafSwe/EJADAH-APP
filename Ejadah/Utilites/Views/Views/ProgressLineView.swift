//
//  ProgressLineView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import SwiftUI

struct ProgressLineView:View{
    @Binding var value :CGFloat
    var body: some View{
        
        ZStack {
//            ProgressView(value: value)
//                .progressViewStyle(LinearProgressViewStyle())
//                .accentColor(.black)
//
//            // on tap gesture to update current value based on the view transition.
//            Circle().frame(width: 20, height: 20, alignment: .center)
//                .offset(x:( width * value ) - 197)
            
            Slider(value: $value, in: 0...100, step: 0.1)
  
            
        }
    }
}

struct ProgressLineView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressLineView(value: .constant(3.44))
    }
}
