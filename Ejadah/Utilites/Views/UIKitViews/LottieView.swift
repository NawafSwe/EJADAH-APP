//
//  LottieView.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 11/03/2021.
//

import Foundation
import UIKit
import Lottie
import SwiftUI
struct LottieView:UIViewRepresentable{
    let fileName:String
    func makeUIView(context: Context) -> some UIView {
        // initing view
        let view = UIView(frame: .zero)
        // init animationView
        let animationView = AnimationView()
        // getting animation with named file
        let animation = Animation.named(fileName)
        
        // setting the animation for the animation view
        animationView.animation = animation
        
        // loop till dismiss
        animationView.loopMode = .loop
        
        // scaling animation
        animationView.contentMode = .scaleAspectFit
        
        //playing animation
        animationView.play()
        
        // setting constrains
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        // adding animation to the view
        view.addSubview(animationView)
        
        // setting constrains values
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
