//
//  UIActivityController.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 03/02/2021.
//

import SwiftUI
struct UIActivityKit : UIViewControllerRepresentable{
    var url:String
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIActivityViewController(activityItems: [NSURL(string: url)!], applicationActivities: nil )
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
struct UIActivityController: View {
    var url:String
    var body: some View {
        UIActivityKit(url: url)
    }
}

struct UIActivityController_Previews: PreviewProvider {
    static var previews: some View {
        UIActivityController(url: K.AXENDA_ACCOUNT.absoluteString)
    }
}
