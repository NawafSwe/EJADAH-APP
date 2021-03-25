//
//  ManagePostView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 01/03/2021.
//

import SwiftUI

struct ManagePostView: View {
    
    @ObservedObject var viewModel : PostListViewModel
    @StateObject var managerViewModel = ManagePostViewViewModel()
    
    var body: some View {
        ZStack{
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0.0){
                ComboHeaderView(title: managerViewModel.title, leftCallBack: self.managerViewModel.enableAddTrack , rightCallBack: viewModel.dismissView, leftButtonTitle: managerViewModel.addTitle, leftButtonIcon: IconsCollection.add, rightButtonIcon: IconsCollection.rightArrow)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing:K.Sizes.scrollVSpacing) {
                        ForEach(viewModel.tracks){track in
                            PostView(track: track)
                                .overlay(
                                    Button(action:{ }){ MoreButtonView() }
                                        .contextMenu {
                                            Button (action:{
                                                self.managerViewModel.selectedPost = track
                                                self.managerViewModel.showEditForm = true
                                            }){
                                                Text(managerViewModel.editOption)
                                            }
                                            
                                            Button { self.managerViewModel.showAlert.toggle() }
                                            label: {
                                                Text(managerViewModel.deleteOption)
                                            }

                                        }
                                        .alert(isPresented: $managerViewModel.showAlert){
                                            Alert(title: Text(self.managerViewModel.alertTitle), message: Text(self.managerViewModel.alertMessage), primaryButton: .destructive(Text(self.managerViewModel.proceedAlertAction)){
                                                self.managerViewModel.selectedPostId = track.id
                                                self.managerViewModel.deletePost()
                                            }
                                            , secondaryButton: .cancel())
                                        }
                                    , alignment: .topTrailing
                               )
                                .onTapGesture {
                                    self.managerViewModel.selectedPost = track
                                    self.managerViewModel.showEditForm = true
                                }
                        }
                    }
                    .padding(EdgeInsets(top: K.Sizes.scrollVPadding, leading: K.Sizes.scrollHPadding, bottom: K.Sizes.scrollVPadding, trailing: K.Sizes.scrollHPadding))
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            if managerViewModel.showAddTrack && viewModel.category.id != nil{
                AddPostView(viewModel: AddPostViewModel(category:  viewModel.category , dismiss : $managerViewModel.showAddTrack, mode: .constant(false) ))
            }
            if managerViewModel.showEditForm && managerViewModel.selectedPost != nil {
                AddPostView(viewModel: AddPostViewModel(category: viewModel.category , post: managerViewModel.selectedPost! , dismiss: $managerViewModel.showEditForm, mode: .constant(true)))
            }
        }
        
    }
}

struct ManageTrackView_Previews: PreviewProvider {
    static var previews: some View {
        ManagePostView(viewModel: PostListViewModel(category: MockCategoryData.categorySample, dismiss: .constant(false)))
    }
}
