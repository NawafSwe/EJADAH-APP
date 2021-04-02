//
//  AddPostViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
import SwiftUI
import AVKit
final class AddPostViewModel:ObservableObject{
    let trackNameLabel = "العنوان:"
    let categoryLabel = "القسم:"
    let relatedLinkPlaceholder = "الرابط المتعلق"
    let addTrackLabel = "إضافة شرح"
    let titleFieldLabel =  "العنوان:"
    let categoryFieldLabel = "الاقسام:"
    let descriptionLabel = "الوصف:"
    let descriptionPlaceholder = "الوصف"
    let editTitle = "تعديل الشرح"
    let saveTitle = "حفظ"
    let publishTitle = "نشر"
    var secondaryButtonTitle: String { mode.wrappedValue ? saveTitle : publishTitle }
    
    @Published var showDocuments = false
    @Published var data:URL? = nil
    @Published var urlString:String = ""
    @Published var repository = PostRepository()
    @Published var dismiss:Binding <Bool>
    @Published var post : TrackService
    @Published var isLoading = false
    @Published var alertItem:AlertItem?
    // will control the func to decide edit mode or add new post
    var mode:Binding<Bool>
    let category : CategoryModel
    
    //MARK:- initialisers
    init(category: CategoryModel , dismiss:Binding<Bool> , mode:Binding<Bool> ){
        self.category = category
        self.dismiss = dismiss
        self.mode = mode
        self.post = TrackService(track: PostModel(title: "", description: "", trackURL: "", trackDuration: 0, isAudio: false, categoryId: self.category.id!, URLShare: ""))
    }
    
    init(category: CategoryModel, post: TrackService , dismiss:Binding<Bool> , mode:Binding<Bool> ){
        self.category = category
        self.post = post
        self.dismiss = dismiss
        self.mode = mode
        
    }
    //MARK:- addTrack
    func addTrack(completion: @escaping (Result<Void, Error>) -> Void)  {
        if !urlString.isEmpty{
            var duration = 0
            let assetKeys = ["playable", "duration"]
            let asset = AVAsset(url: data!)
            asset.loadValuesAsynchronously(forKeys: assetKeys, completionHandler: {
                DispatchQueue.main.async { [self] in
                    let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
                    duration = Int(CMTimeGetSeconds(playerItem.duration) / 60 )
                    let track  = PostModel(title: post.track.title, description: post.track.description, trackURL: urlString, trackDuration: duration , isAudio: isAudio() , categoryId: self.category.id!, URLShare: urlString)
                    repository.addTrack(track: track){ result in
                        switch result{
                            case .success(_):
                                completion(.success( () ))
                                return
                                
                            case .failure(let error):
                                completion(.failure(error))
                                return
                        }
                    }
                }
            })
        }
    }
    
    //MARK:- uploadFile
    // func to upload file
    func uploadFile(completion: @escaping (Result<Void, Error>) -> Void){
        DispatchQueue.main.async {
            self.isLoading = true
            if self.data != nil{
                print(self.data!)
                PostRepository.shared.uploadData(file: self.data! ){result in
                    switch result{
                        case .success(let url):
                            PostRepository.shared.getURL(file: url){result in
                                switch result{
                                    case .success(let url):
                                        DispatchQueue.main.async {
                                            self.urlString = url.absoluteString
                                            self.isLoading = false
                                            completion(.success( () ))
                                            return
                                            
                                        }
                                    case .failure(let error):
                                        self.isLoading = false
                                        completion(.failure(error))
                                        return
                                        
                                }
                            }
                        case .failure(let error):
                            
                            self.isLoading = false
                            self.alertItem = AlertItem(title: Text("Uploading Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                            
                    }
                }
            }
        }
    }
    
    /// checking imported file is audio or video
    /// - returns bool indicates if it is audio or video
    func isAudio()->Bool{
        guard let data = data else{ return false }
        switch data.pathExtension {
            case "mp3":
                return true
            case "mp4":
                return false
            default:
                return true
        }
    }
    
    // dismissing current view
    func dismissView(){ self.dismiss.wrappedValue.toggle() }
    func getHeaderTitle()->String{ mode.wrappedValue ? editTitle : addTrackLabel }
    
    // getting the button based on the mode action
    func getDeleteButton()-> some View{
        return Button(action:{
            // guard let id = self.post.id else {return}
            self.repository.deletePost(self.post.id)
        }){ MainButtonView(title: "حذف" , color: Color.mainText, width: UIScreen.width / 5 * 1.2 , height: UIScreen.height / 4 * 0.18 ) }
    }
    func getPublishButton()->some View{
        Button(action:{   self.showDocuments.toggle()  }){
            MainButtonView(title: "نشر الشرح" , color: Color.mainText, width: UIScreen.width / 3 * 1.46 , height: UIScreen.height / 3 * 0.18 )
                .overlay(
                    Image(IconsCollection.plus)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                        .padding(.trailing)
                    , alignment: .trailing)
        }
    }
    
    func secondaryCallBack(){
        if mode.wrappedValue{
            //            guard let post = self.post else {return}
            //            let updatedPost = TrackModel(id: post.id, title: self.postTitle, description: self.description, trackURL: post.trackURL, trackDuration: post.trackDuration, isAudio: post.isAudio, categoryId: post.categoryId, URLShare: post.URLShare)
            //            self.repository.updatePost(post: updatedPost)
        }else{
            // first uploading file
            self.uploadFile(){result in
                // checking result of uploading file if went success or not
                switch result{
                    case .success():
                        self.addTrack(){result in
                            switch result{
                                case .success():
                                    self.alertItem = AlertItem(title: Text("نجاح"), message: Text("تم اضافه الشرح بنجاح"), dismissButton: .default(Text("حسنا")))
                                case .failure(let error):
                                    self.alertItem = AlertItem(title: Text("خطا"), message: Text(error.localizedDescription), dismissButton: .default(Text("حسنا")))
                            }
                        }
                        
                    case .failure(let error):
                        self.alertItem = AlertItem(title: Text("Uploading Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                }
            }
            
        }
    }
}
