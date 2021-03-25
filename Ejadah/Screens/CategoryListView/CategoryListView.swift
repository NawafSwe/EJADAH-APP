//
//  CategoryListView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 03/01/2021.
//

import SwiftUI
//MARK:- HomeView
struct CategoryListView: View {
    @StateObject private var viewModel = CategoryViewModel()
    let title = "الرئيسية"
    var body: some View {
        ZStack {
            Color.mainBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                ComboHeaderView(title: title)
                     .accessibility(label: AccessibilitiesDescription.headerCategoryTitle.label)
                     .accessibility(sortPriority: 1)
                        
                    ScrollView {
                            LazyVGrid(columns: viewModel.columns, spacing: K.Sizes.scrollVSpacing) {
                                
                                ForEach(viewModel.categories){ category in
                                
                                    // passing category in categoryView
                                    CategoryView(category: category)
                                        // can be changed
                                        //.accessibility(label: Text( category.category.title) )
                                        .accessibility(sortPriority: 0)
                                        .onTapGesture { self.viewModel.selectedCategory =  category }
                                }
                            
                             
                            }.padding(EdgeInsets(top: K.Sizes.scrollVPadding, leading: K.Sizes.scrollHPadding, bottom: K.Sizes.scrollVPadding, trailing: K.Sizes.scrollHPadding))
                    }
            }.edgesIgnoringSafeArea(.all)
            // pass categoryService obj
            if viewModel.selectedCategory != nil &&  viewModel.didSelectCategory {
                
                Color.mainBackground
                    .edgesIgnoringSafeArea(.all)
                PostListView(viewModel: PostListViewModel(category: viewModel.selectedCategory!.category , dismiss: $viewModel.didSelectCategory))
                    .animation(.easeIn(duration: 0.3))
                    .animation(nil)
                 }
          }
            .accessibilityElement(children: .contain)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryListView()
            .previewDevice(K.Devices.iPhone12ProMax)
                            
        }
    }
}
