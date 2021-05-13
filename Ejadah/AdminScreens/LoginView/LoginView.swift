//
//  LoginView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 19/02/2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel:LoginViewModel
    var body: some View {
        ZStack{
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 60){
                Text(viewModel.screenTitle)
                    .font(Font.custom(K.TajwalFonts.bold, size: 36))
                    .foregroundColor(.durationBackground)
                VStack( spacing: 40){
                    VStack(alignment: .leading , spacing: 10){
                        Text(viewModel.usernameField)
                            .font(Font.custom(K.TajwalFonts.regular, size: 18))
                            .foregroundColor(.mainText)
                            .padding(.horizontal)
                        TextField("الايميل", text: $viewModel.email)
                            .disableAutocorrection(true)
                            .textContentType(.emailAddress)
                            .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                            .foregroundColor(.black)
                            .padding(.horizontal)
         
                    }
                    // since language is english and we are using Arabic we want to force direction of text fields
                    .environment(\.layoutDirection, .rightToLeft)
                    
                   
                    
                    VStack(alignment: .leading , spacing: 10){
                        Text(viewModel.passwordField)
                            .font(Font.custom(K.TajwalFonts.regular, size: 18))
                            .foregroundColor(.mainText)
                            .padding(.horizontal)
                        SecureField(" كلمه المرور", text: $viewModel.password)
                            .textContentType(.password)
                            .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                            .foregroundColor(.black)
                            
                        
                    }
                    // since language is english and we are using Arabic we want to force direction of text fields
                    .environment(\.layoutDirection, .rightToLeft)
                    
                    
                    Button(action:{ viewModel.login(with: viewModel.email, password: viewModel.password)  }){
                        MainButtonView(title: viewModel.loginTitle, width: UIScreen.width / 3, height: UIScreen.height / 4 * 0.2)
                    }
                }
                .alert(item: $viewModel.alertItem){alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                }
                Spacer().frame(height: UIScreen.height / 4 * 0.7)
                
            }
        }
        .onTapGesture(perform:K.dismissKeyBoard)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel() )
    }
}
