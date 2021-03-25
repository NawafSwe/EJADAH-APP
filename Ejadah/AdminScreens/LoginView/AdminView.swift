//
//  AdminView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import SwiftUI
import FirebaseAuth
struct AdminView: View {
    @ObservedObject private var shared = AuthenticationManager.shared
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        ZStack{
            if  Auth.auth().currentUser == nil   {
                LoginView(viewModel: viewModel)
                
            }else{
                ManageCategoryView()
            }
        }
        .onAppear(perform: { shared.listen() })
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
