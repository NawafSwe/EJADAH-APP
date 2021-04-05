//
//  CategoryRepository.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine
import SwiftUI
final class CategoryRepository:ObservableObject{
    @Published var categories : [CategoryModel] = [CategoryModel]()
    // @Published var queriedCategories: [CategoryModel] = [CategoryModel]()
    private final let db = Firestore.firestore()
    private final let collectionName = K.FirebaseCollections.category
    private final let dummyData : [CategoryModel] = [
        CategoryModel(title:"مقاطع فديو عشوائيه", trackNumber: 0),
        CategoryModel(title: "صوتيات دينيه", trackNumber: 0),
        CategoryModel(title: "الحياه والترتيب", trackNumber: 0),
        CategoryModel(title: "الترفيه والالعاب", trackNumber: 0),
    ]
    
    init(){
        self.loadData()
        
    }
    /// loading all categories from firebase
    func loadData(){
        // loading all categories that has a
        db.collection(self.collectionName)
            //            .whereField("trackNumber", isGreaterThan: 0)
            .addSnapshotListener { (query, error) in
                if let error = error {
                    fatalError("\(error.localizedDescription)")
                }
                if let query = query{
                    // using compact map in case there is nil values
                    
                    self.categories =  query.documents.compactMap{doc in
                        let coded = try? doc.data(as: CategoryModel.self)
                        return coded
                        
                        
                    }
                }
            }
    }
    
    /// adding new category to firestore
    /// - Parameter category: category model that has the data
    func addCategory(_ category: CategoryModel , completion: @escaping (Result<Void, Error>) -> Void){
        do{
            let _ = try db.collection(collectionName).addDocument(from: category){error in
                if error != nil {
                    //fatalError(error!.localizedDescription)
                    completion(.failure(error!))
                    return
                }
                completion(.success( () ))
                return
            }
            completion(.success( () ))
            return
            
        }catch let error{
            completion(.failure(error))
            return
            //            fatalError(error.localizedDescription)
        }
    }
    /// seed data to firestore by adding new dummy category
    //func seedData(){ for cat in dummyData{ self.addCategory(cat) } }
    
    func deleteCategory(_ id:String , completion:@escaping (Result<Void, Error>)->Void){
        self.db.collection(collectionName).document(id).delete { (error) in
            if let error = error{
                print(error)
                // throw alert error
                completion(.failure(error))
                return
            }
            completion(.success( () ))
            return 
        }
    }
    
    func updateCategory(category: CategoryModel, completion: @escaping (Result<Void, Error>)->Void){
        guard let id = category.id else{ return }
        do{
            try self.db.collection(collectionName).document(id).setData(from: category){error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
            }
            
            completion(.success( () ))
            
        }catch{
            print(error)
            completion(.failure(error))
            return
            
        }
    }
}
