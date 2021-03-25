//
//  PostListViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 11/01/2021.
//

import Foundation
import SwiftUI
import Combine
final class PostListViewModel:ObservableObject{
    //MARK:- states
    @Published var didSelectTrack:Bool = false
    
    @Published var selectedTrack : PostModel? { didSet{self.didSelectTrack = true } }
    
    @Published var trackList: [PostModel] = MockTrackData.postList
    
    // to make user sees what he/she types if he/she is searching
    @Published var didKeyboardAppear = false
    
    @Published var showPlayerView = false
    @Published var trackRepository = PostRepository()
    @Published var tracks = [TrackService]()
    var dismiss: Binding<Bool>
    var category :CategoryModel
    var categoryId = ""
    let columns:[GridItem] = [GridItem(.flexible())]
    private var cancellbles = Set<AnyCancellable>()
    
    //MARK:- init
    /// receiving tracks from firebase
    init(category:CategoryModel , dismiss:Binding<Bool>){
        self.dismiss = dismiss
        self.category = category
        // loading tracks for proper category
        self.trackRepository.loadTracksWithId(self.category.id!)
        // mapping all relevant tracks
        self.trackRepository.$customTracks
            .map{ tracks in
                tracks.map{track in
                    TrackService(track: track)
                }
            }
            .assign(to: \.tracks, on: self)
            .store(in: &cancellbles)
        
    }
    //MARK:- dismiss current screen
    /// dismissing current view 
    func dismissView(){
        self.dismiss.wrappedValue.toggle()
        
        
    }
}

