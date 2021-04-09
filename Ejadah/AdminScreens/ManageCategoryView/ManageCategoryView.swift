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
                //                ComboHeaderView(title: managerViewModel.title, leftCallBack: managerViewModel.enableAddCategory, rightCallBack: AuthenticationManager.shared.logout, leftButtonTitle: managerViewModel.addTitle, leftButtonIcon: IconsCollection.add, rightButtonIcon: IconsCollection.logout)
                TwoButtonsHeader(title:  managerViewModel.title, leftCallBack: managerViewModel.enableAddCategory, rightCallBack: AuthenticationManager.shared.logout, leftIcon: IconsCollection.add, rightIcon: IconsCollection.logout)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing:K.Sizes.scrollVSpacing) {
                        ForEach(viewModel.categories){category in
                            CategoryView(category:  category)
                                .overlay(
                                    Button(action:{}){ MoreButtonView() }
                                        .contextMenu {
                                            Button {
                                                self.managerViewModel.showUpdateCategory = true
                                            } label: {
                                                Text(managerViewModel.editOption)
                                                
                                            }
                                            
                                            Button {
                                                self.managerViewModel.showAlert.toggle()
                                            } label: { Text(managerViewModel.deleteOption) }
                                        }
                                        
                                        
                                        
                                        .alert(isPresented: $managerViewModel.showAlert){
                                            Alert(title: Text(self.managerViewModel.alertTitle), message: Text(self.managerViewModel.alertMessage), primaryButton: .destructive(Text(self.managerViewModel.proceedAlertAction)){
                                                self.managerViewModel.selectedCategoryId = category.id
                                                self.managerViewModel.deleteCategory()
                                            }
                                            , secondaryButton: .cancel())
                                        }
                                    , alignment: .topTrailing
                                )
                                
                                .onTapGesture {
                                    self.viewModel.selectedCategory = category
                                    
                                    
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
            if managerViewModel.showUpdateCategory && viewModel.selectedCategory != nil {
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

struct TwoButtonsHeader:View{
    let title:String
    let leftCallBack: ()->Void
    let rightCallBack:()->Void
    let leftIcon:String
    let rightIcon:String
    
    var body:some View{
        HStack{
            Button(action: leftCallBack ){
                Image(leftIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                
            }
            .padding(.leading)
            Spacer()
            Text(title)
                
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 20, type: K.TajwalFonts.bold, fixedSizeHr: true, fixedSizeVr: false, alignment: .center))
                .padding(.horizontal)
            Spacer()
            Button(action:rightCallBack){
                Image(rightIcon)
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                
            }
            .padding(.trailing)
            
        }
        .padding(.top)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8)
        .background(Color.headerColor)
        .shadow(radius: 10, x: 0.0, y: 4)
        .edgesIgnoringSafeArea(.top)
    }
}
