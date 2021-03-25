//
//  BlurView.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 11/03/2021.
//

import Foundation
import UIKit
import SwiftUI

struct BlurView:UIViewRepresentable{
    //.system will be adaptive
    @State var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        // initing blur effect and UIVisualEffectView
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // setting constrains
        blurView.translatesAutoresizingMaskIntoConstraints = false
        //0 is the first underneath all views
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
        return view
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
