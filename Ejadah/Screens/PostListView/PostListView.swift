//
//  PostListView.swift
//  EjadahApp
//
//  Created by Nawaf B Al sharqi on 04/01/2021.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var viewModel : PostListViewModel
    // customizing tab bar furthermore
    init(viewModel: PostListViewModel){ self.viewModel = viewModel }
    var body: some View {
        ZStack {
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0.0) {
                ComboHeaderView(title: "الشروحات", rightButtonIcon: IconsCollection.rightArrow, rightCallBack: self.viewModel.dismissView)
                    .accessibility(sortPriority: 1)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing:K.Sizes.scrollVSpacing){
                        ForEach(viewModel.tracks){track in
                            PostView(track: track)
                                .accessibility(sortPriority: 0)
                                .padding(5)
                                .onTapGesture {
                                     self.viewModel.showPlayerView.toggle()
                                     self.viewModel.selectedTrack = track.track
                                }
                        }
                        
                    }.padding(EdgeInsets(top: K.Sizes.scrollVPadding, leading: K.Sizes.scrollHPadding, bottom: K.Sizes.scrollVPadding, trailing: K.Sizes.scrollHPadding))
                }
            }.edgesIgnoringSafeArea(.all)
            
            if viewModel.didSelectTrack && viewModel.selectedTrack != nil {
                Color.mainBackground.edgesIgnoringSafeArea(.all)
                MediaPlayerView(viewModel: MediaPlayerViewModel(track: viewModel.selectedTrack!, dismiss: $viewModel.didSelectTrack))
                    .animation(.easeIn(duration: 0.3))
                    .animation(nil)
            }
        }
        .accessibilityElement(children: .contain)
       
    }
    
}
struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(viewModel: PostListViewModel(category: MockCategoryData.categorySample, dismiss: .constant(false)))
          
    }
}
