//
//  AuthenticationManager.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
 //MARK:- UserState
enum UserState{ case signIn, singOut , null }
 //MARK:- UserModel
struct UserModel:Codable , Identifiable{
    @DocumentID var id:String?
    var name:String
    var email:String
    
}

 //MARK:- AuthenticationManager
final class AuthenticationManager:ObservableObject{
    @Published var currentState = UserState.null
    var handle:AuthStateDidChangeListenerHandle? = nil
    @Published var user:UserModel? = nil
    static let shared = AuthenticationManager()
    private init(){ }
    
    func listen(){
        self.handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            // there is user
            if let _ = user { DispatchQueue.main.async { self.currentState = .signIn }
            }else { DispatchQueue.main.async { self.currentState = .singOut } }
        })
    }
    
    func login(email:String , password:String , completion: @escaping(Result<Void, Error>) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password){ (auth, error) in
            if let error = error{
                completion(.failure(error))
                return
            }
            // checking if there is user or not
            if let _ = auth?.user{
                DispatchQueue.main.async { self.currentState = .signIn }
                completion(.success( ( ) ))
                return
            }
        }
    }
    
    func logout(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.async { self.currentState = .singOut }
            self.unbind()
            return
        }catch {
            // throw alert
        }
        
    }
    
    /// stop listing
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}

