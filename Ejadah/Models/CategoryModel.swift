//
//  CategoryModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct CategoryModel: Codable , Hashable ,Identifiable{
    // getting document id if exist
    @DocumentID var id:String?
    var title:String
    var trackNumber:Int
}
//MARK:- MockCategoryData
/// holding dummy data of some categoryData
struct MockCategoryData {
    static public let categoryList : [CategoryModel] = [
        CategoryModel(id: "1", title: "مهارات يومية", trackNumber: 4),
        CategoryModel(id: "2", title: "الصوتيات والمرئيات", trackNumber: 2),
        CategoryModel(id: "3", title: "أجهزة وملحقات", trackNumber: 3),
        CategoryModel(id: "4", title: "التواصل الاجتماعيه شبكات", trackNumber: 6),
        CategoryModel(id: "5", title: "الألعاب والترفيه", trackNumber: 9),
    ]
    static public let categorySample:CategoryModel = CategoryModel(title: "مهارات يومية", trackNumber: 4)
    
}
