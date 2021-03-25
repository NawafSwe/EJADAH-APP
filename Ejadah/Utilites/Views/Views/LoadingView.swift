//
//  LoadingView.swift
//  Ejadah
//
//  Created by Nawaf B Al sharqi on 11/03/2021.
//

import SwiftUI

struct LoadingView: View {
    let fileName:String
    @Binding var isLoading:Bool
    var body: some View {
        ZStack {
            if isLoading{
                LottieView(fileName: fileName)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(BlurView(style: .systemMaterial))
                    .cornerRadius(25)
                    .shadow(radius: 5)
                
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(fileName: K.Files.uploadLoading , isLoading: .constant(true))
    }
}
