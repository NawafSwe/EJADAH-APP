//
//  ManageCategoryView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 24/02/2021.
//

import SwiftUI

struct ManageCategoryView: View {    
    @StateObject var viewModel = CategoryViewModel()
    @StateObject var managerViewModel = ManageCategoryViewModel()
    var body: some View {
        ZStack{
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0){
                TwoButtonsHeaderView(title:  managerViewModel.title, leftCallBack: AuthenticationManager.shared.logout , rightCallBack: managerViewModel.enableAddCategory, leftIcon:IconsCollection.logout , rightIcon:  IconsCollection.add)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing:K.Sizes.scrollVSpacing) {
                        ForEach(viewModel.categories){category in
                            CategoryView(category:  category)
                                //  .overlay(
                                //    Button(action:{}){ MoreButtonView() }
                                //                                 .contextMenu {
                                //                            Button {
                                //                                DispatchQueue.main.async {
                                //                                    // selecting category
                                //                                    self.viewModel.selectedCategory = category
                                //                                    self.managerViewModel.showUpdateCategory = true
                                //                                }
                                //
                                //                            } label: {
                                //                                Text(managerViewModel.editOption)
                                //
                                //                            }
                                //
                                //                            Button {
                                //                                self.managerViewModel.showAlert.toggle()
                                //                            } label: { Text(managerViewModel.deleteOption) }
                                //                        }
                                //
                                //                        .alert(isPresented: $managerViewModel.showAlert){
                                //                            Alert(title: Text(self.managerViewModel.alertTitle), message: Text(self.managerViewModel.alertMessage), primaryButton: .destructive(Text(self.managerViewModel.proceedAlertAction)){
                                //                                self.managerViewModel.selectedCategoryId = category.id
                                //                                self.managerViewModel.deleteCategory()
                                //                            }
                                //                            , secondaryButton: .cancel())
                                //                        }
                                //, alignment: .topTrailing)
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        self.viewModel.selectedCategory = category
                                        self.viewModel.didSelectCategory = true
                                    }
                                    
                                    
                                }
                        }
                    }
                    .padding(EdgeInsets(top: K.Sizes.scrollVPadding, leading: K.Sizes.scrollHPadding, bottom: K.Sizes.scrollVPadding, trailing: K.Sizes.scrollHPadding))
                }
                
                
            }
            .edgesIgnoringSafeArea(.all)
            
            if viewModel.didSelectCategory && viewModel.selectedCategory != nil{
                Color.mainBackground
                    .edgesIgnoringSafeArea(.all)
                ManagePostView(viewModel: PostListViewModel(category: viewModel.selectedCategory!.category, dismiss: $viewModel.didSelectCategory))
                    .animation(.easeIn(duration: 0.3))
                    .animation(nil)
            }
            
            if managerViewModel.showAddCategory{
                AddCategoryView(viewModel: AddCategoryViewModel(dismiss: $managerViewModel.showAddCategory, mode: .constant(false)))
            }
            if managerViewModel.showUpdateCategory && self.viewModel.selectedCategory != nil  {
                AddCategoryView(viewModel: AddCategoryViewModel(dismiss: $managerViewModel.showUpdateCategory, mode: .constant(true), category: viewModel.selectedCategory!))
            }
            
        }
        
    }
}

struct ManageCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ManageCategoryView()
    }
}
