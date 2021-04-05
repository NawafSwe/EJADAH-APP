//
//  AddCategoryViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/03/2021.
//

import Foundation
import SwiftUI
final class AddCategoryViewModel:ObservableObject{
    let addCategory = "إضافة قسم"
    let publishButton = "حفظ"
    var dismiss: Binding<Bool>
    var mode:Binding<Bool>
    var category:CategoryService
    @Published var alertItem:AlertItem? = nil
    @Published private var categoryRepository = CategoryRepository()
    init(dismiss:Binding<Bool>, mode:Binding<Bool>){
        self.dismiss = dismiss
        self.mode = mode
        self.category = CategoryService(category: CategoryModel(title: "", trackNumber: 0))
    }
    
    init(dismiss:Binding<Bool>, mode:Binding<Bool> , category:CategoryService ){
        self.dismiss = dismiss
        self.mode = mode
        self.category = category
        
    }
    
    
    //MARK:- functions
    
    //MARK:- dismiss view
    func dismissView(){ self.dismiss.wrappedValue.toggle() }
    
    //MARK:- callBackPublishButton
    func callBackPublishButton(){
        // if mode true then it is update mode
        if mode.wrappedValue{
            self.categoryRepository.updateCategory(category: self.category.category){result in
                switch result{
                    case .success():
                        self.alertItem = AlertItem(title: Text("نجاح"), message: Text("تمت إضافة القسم بنجاح"), dismissButton: .default(Text("حسنا")))
                        return 
                    case .failure(let error):
                        self.alertItem = AlertItem(title: Text("فشل"), message:Text(error.localizedDescription), dismissButton: .default(Text("حسنا")))
                        return
                }
                
            }
        }else {
            let categoryModel = CategoryModel(title: self.category.category.title, trackNumber: category.category.trackNumber)
            self.categoryRepository.addCategory(categoryModel){result in
                
            }
        }
    }
}
