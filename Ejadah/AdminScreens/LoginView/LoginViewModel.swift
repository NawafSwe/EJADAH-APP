//
//  LoginViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
import SwiftUI
 //MARK:- LoginViewModel
final class LoginViewModel:ObservableObject{
    let screenTitle = "تسجيل الدخول"
    let usernameField  = "اسم المستخدم:"
    let passwordField = "كلمة المرور:"
    let loginTitle = "تسجيل الدخول"
    @Published var showDocuments = false
    @Published var email = ""
    @Published var password = ""
    @Published var alertItem:AlertItem?
    
    func login(with email:String , password:String){
        AuthenticationManager.shared.login(email: self.email, password: self.password) { (result) in
            switch result{
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Login Error"), message: Text("\(error.localizedDescription)"), dismissButton: Alert.Button.default(Text("OK")))
                    }
                case .success( (_) ):
                    return

            }
        }
    }
    
}
