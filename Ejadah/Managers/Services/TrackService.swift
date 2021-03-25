//
//  TrackService.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 23/01/2021.
//

import Foundation
import Combine
import SwiftUI
final class TrackService:ObservableObject , Identifiable{
    @Published var track:PostModel
    @Published var trackRepository = PostRepository()
    private var cancellables = Set<AnyCancellable>()
    var id = ""
    init(track:PostModel){
        self.track = track
        // mapping track id 
        $track.compactMap{track in
            track.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }
}
