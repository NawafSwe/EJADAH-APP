//
//  TrackRepository.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

final class PostRepository:ObservableObject{
    @Published var tracks = [PostModel]()
    @Published var customTracks = [PostModel]()
    private final let db = Firestore.firestore()
    private final let collectionName = K.FirebaseCollections.track
    private final let storage = Storage.storage()
    static let shared = PostRepository() 
    
    private final let dummyData :[PostModel] = [
        // cat 3
        PostModel(title: "سوره الاخلاص", description: "قراءة سوره الاخلاص", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/sound2.mp3?alt=media&token=c1157618-8562-4b13-b730-5f393ba81d10", trackDuration: 4, isAudio: true, categoryId: "L6KNxzxyikJs8MNcFeHj", URLShare: ""),
        
        //cat 3
        PostModel(title:"سوره الكهف", description: "قراءة سوره الكهف", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/sound1.mp3?alt=media&token=7104430c-9445-47c3-abe5-08c71b94c668", trackDuration: 5, isAudio: true, categoryId: "L6KNxzxyikJs8MNcFeHj", URLShare: ""),
        
        // cat 2
        PostModel(title: "مقطع اكسندا للتحديثات", description: "مقاطع اكسندا وشروحاتهم", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/Axenda%20%7C%20%D8%A7%D9%83%D8%B3%D9%86%D8%AF%D8%A7%204.mp4?alt=media&token=9abb29ec-239d-4937-8c41-1c9f10e6f839", trackDuration: 4, isAudio: false, categoryId: "HIHgxKdoQhb4eJ3IENGI", URLShare: "https://twitter.com/AxendaTeam"),
        
        //cat 1
        PostModel(title: "مقطع اكسندا", description: "مقطع عن اكسندا", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/Axenda%20%7C%20%D8%A7%D9%83%D8%B3%D9%86%D8%AF%D8%A7%204.mp4?alt=media&token=9abb29ec-239d-4937-8c41-1c9f10e6f839", trackDuration: 4, isAudio: false, categoryId: "8aUqWyBd64KJJM6ks9gh",URLShare: "https://twitter.com/Nawaf_B_910" ),
        
        // cat4
        PostModel(title: "مقدمه عن اكسندا", description: "التعريف بفريق اكسندا الرهيب", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/Axenda%20%7C%20%D8%A7%D9%83%D8%B3%D9%86%D8%AF%D8%A7%204.mp4?alt=media&token=9abb29ec-239d-4937-8c41-1c9f10e6f839", trackDuration: 4, isAudio: false, categoryId: "mMfcTPiUgsIXM6XayxAD", URLShare: ""),
        
        PostModel(title:"سوره الكهف", description: "قراءة سوره الكهف", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/sound1.mp3?alt=media&token=7104430c-9445-47c3-abe5-08c71b94c668", trackDuration: 5, isAudio: true, categoryId: "mMfcTPiUgsIXM6XayxAD" , URLShare: "https://twitter.com/Nawaf_B_910"),
        
        PostModel(title: "مقطع اكسندا", description: "مقطع عن اكسندا", trackURL: "https://firebasestorage.googleapis.com/v0/b/manhal-14654.appspot.com/o/Axenda%20%7C%20%D8%A7%D9%83%D8%B3%D9%86%D8%AF%D8%A7%204.mp4?alt=media&token=9abb29ec-239d-4937-8c41-1c9f10e6f839", trackDuration: 4, isAudio: false, categoryId: "mMfcTPiUgsIXM6XayxAD", URLShare: "https://twitter.com/Nawaf_B_910"),
        
        
    ]
    init(){
        self.loadData()
        
    }
    
    /// loading all tracks from db
    func loadData(){
        db.collection(self.collectionName).addSnapshotListener { (query, error) in
            if let error = error {
                fatalError("\(error.localizedDescription)")
                
            }
            if let query = query{
                self.tracks = query.documents.compactMap{ doc in
                    let coded = try? doc.data(as: PostModel.self)
                    return coded
                }
            }
        }
    }
    
    /// load tracks with category id
    /// - Parameter id: category id
    func loadTracksWithId(_ id:String){
        db.collection(self.collectionName)
            .whereField("categoryId", isEqualTo: id)
            .addSnapshotListener { (query, error) in
                if let error = error{
                    fatalError(error.localizedDescription)
                }
                if let query = query{
                    self.customTracks = query.documents.compactMap{doc in
                        let coded = try? doc.data(as: PostModel.self)
                        return coded
                        
                    }
                }
            }
    }
    
    /// add new track to fireStore
    /// - Parameter track: adding new track
    func addTrack(track:PostModel){
        do{
            updateCategory(track.categoryId)
            let _ = try db.collection(collectionName).addDocument(from: track){_ in}
        }catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    /// seeding database
    //    func seedData(){
    //        for k in dummyData{
    //            addTrack(track: k)
    //        }
    //    }
    
    /// increment track list of certain category by one
    func updateCategory(_ id:String){
        db.collection(K.FirebaseCollections.category).document(id).updateData(["trackNumber" : FieldValue.increment(Int64(1)) ])
    }
    
    /// uploading videos or audio to storage
    /// - Parameters:
    ///   - file: file url
    ///   - completion: completion handler that will return bool to indicate that process went done success or error in case of anything went wrong
    func uploadData(file: URL, completion: @escaping (Result<String, Error> )-> Void ){
        let ref = self.storage.reference()
        // child will be media/<catName>/<trackName>
        let name = file.pathComponents.last == nil ? UUID().uuidString : file.pathComponents.last!
        let fullPath = "\(name)"
        let child = ref.child("media/\(fullPath)")
        child.putFile(from: file , metadata: nil){ (meta , error) in
            if let error = error {
                print("error from err side")
                completion(.failure(error))
                return
            }
            guard let _ = meta else {
                print("error in meta")
                return
            }
            completion(.success(fullPath))
            return
        }
    }
    
    /// getting url of posted sound to firebase
    /// - Parameter ref: reference of the posted sound
    /// - Parameter completion: completion handler that will return either url or error
    func getURL(file:String, completion: @escaping (Result<URL, Error>)-> Void){
        storage.reference().child("media/\(file)")
            .downloadURL { (url, error) in
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                if let url = url {
                    completion( .success(url) )
                    return
                }
            }
    }
    
    func deletePost(_ id: String){
        self.db.collection(self.collectionName).document(id).delete { (error) in
            if let error = error {
                print(error)
                // throw alert error
            }
        }
    }
    
    func updatePost(post:PostModel){
        guard let id = post.id else{return}
        do{
            try db.collection(collectionName).document(id).setData(from: post)
            // went fine
        }catch {
            print(error)
        }
    }
}
