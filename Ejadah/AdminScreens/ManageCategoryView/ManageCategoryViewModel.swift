//
//  ManageCategoryViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
import SwiftUI

final class ManageCategoryViewModel:ObservableObject{
    let title = "تعديل الاقسام"
    let addTitle = "إضافة"
    let deleteOption = "حذف القسم"
    let editOption  = "تعديل القسم"
    var selectedCategoryId:String? = nil
    let alertMessage = "سيتم حذف الأقسام التي تم تحديدها، هل أنت متأكد؟"
    let alertTitle = "حذف قسم"
    let cancelAlertAction = "إالغاء"
    let proceedAlertAction = "حذف"
    @Published var showAlert = false 
    @Published var showAddCategory = false
    @Published var didSelectCategory = false 
    @Published var repository = CategoryRepository()
    @Published var showUpdateCategory = false
    @Published var alertItem:AlertItem? = nil
    
    func enableAddCategory(){   self.showAddCategory.toggle()   }
    
    func deleteCategory(){
        guard let id = selectedCategoryId else {
            return
        }
        self.repository.deleteCategory(id){ [self] result in
            switch result{
                case .success():alertItem = AlertItem(title: Text("نجاح"), message: Text("تم حذف القسم بنجاح"), dismissButton: .default(Text("حسنا") ))
                case .failure(let error): alertItem = AlertItem(title: Text("فشل"), message: Text(error.localizedDescription), dismissButton: .default(Text("حسنا")))
                    
                    
            }
            
        }
    }
}
