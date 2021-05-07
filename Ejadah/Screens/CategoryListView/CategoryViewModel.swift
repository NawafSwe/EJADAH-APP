//
//  CategoryViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 11/01/2021.
//
import Foundation
import SwiftUI
import Combine
final class CategoryViewModel:ObservableObject{
    //MARK:- Attributes
    @Published var didSelectCategory: Bool = false
    
    @Published var selectedCategory: CategoryService? = nil 
    
    
    
    @Published  var categoryRepository = CategoryRepository()
    
    private var cancellables = Set<AnyCancellable>()
    
    //creating lazy grid , flexible telling him fill the size of the screen as much as you can
    //each gridItem inside the grid item array represents number of columns
    let columns : [GridItem] = [GridItem(.flexible())]
    
    /// debugging  value
    @Published var categoryList: [CategoryModel] = MockCategoryData.categoryList
    
    /// categories hold a  published category Object which subscribed to categoryRepository
    @Published var categories = [CategoryService]()
    
    /// receiving all categories from firebase
    init(){
        self.categoryRepository
            .$categories.map{ categories in
                categories.map{category in
                    
                    CategoryService(category: category)
                    
                }
            }
            .assign(to:\.categories, on: self)
            .store(in: &cancellables)
        
    }
}
