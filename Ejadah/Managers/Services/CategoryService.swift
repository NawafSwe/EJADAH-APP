//
//  CategoryService.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 22/01/2021.
//

import Foundation
import SwiftUI
import Combine
final class CategoryService: ObservableObject , Identifiable {
    @Published var category:CategoryModel
    @Published var categoryRepository = CategoryRepository()
    private var cancellables = Set<AnyCancellable>()
    var id: String = ""
    init(category:CategoryModel){
        self.category = category
        
        // mapping id for category if get set
        $category.compactMap{ category in
            category.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
}
