//
//  ManageTrackViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
final class ManagePostViewViewModel:ObservableObject{
    let title = "تعديل الشروحات"
    let addTitle = "إضافة"
    let editOption = "تعديل الشرح"
    let deleteOption = "حذف الشرح"
    let alertMessage = "سيتم حذف الشروحات التي تم تحديدها، هل أنت متأكد؟"
    let alertTitle = "حذف شرح"
    let cancelAlertAction = "إالغاء"
    let proceedAlertAction = "حذف"
    @Published var showAlert = false
    @Published var showAddTrack = false
    @Published var repository = PostRepository()
    @Published var selectedPostId:String? = nil
    @Published var selectedPost:TrackService? = nil
    @Published var showEditForm = false 
    func enableAddTrack(){   self.showAddTrack.toggle()   }
    
    func deletePost(){
        guard let id =  selectedPostId else {
            // throw alert
            return }
        self.repository.deletePost(id)
    }
}

