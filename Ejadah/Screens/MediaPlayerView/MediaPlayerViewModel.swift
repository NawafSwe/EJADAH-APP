//
//  PlayerBoxViewModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 11/01/2021.
//

import Foundation
import SwiftUI
import Combine
import Firebase
final class MediaPlayerViewModel:ObservableObject{
    //MARK:- Attributes
    // sound manager player
    @ObservedObject var soundManager = SoundPlayerManager()
    @Published var progressTime: TimeInterval = 0.0
    @Published var fullDuration: TimeInterval = 0.0
    @Published var isPlaying = false
    @Published var presentActivity = false
    var dismiss: Binding<Bool>
    
    // getting the track itself
    var track : PostModel
    private var cancellables = Set<AnyCancellable>()
    
    //MARK:- init
    init(track:PostModel , dismiss: Binding<Bool>){
        self.dismiss = dismiss
        self.track = track        
        soundManager.$isPlaying.map{value in
            value
        }
        .assign(to: \.self.isPlaying, on: self)
        .store(in: &cancellables)
        
        // listing for changes in progress time values
        soundManager.$fullDuration
            .sink{duration in
                self.fullDuration = duration
            }
            .store(in: &cancellables)
    }
    
    
    
    // getting share url for the current screen
    /// getting url for share
    /// - returns return a full url of the track within the app
    func getShareUrl()->URL{
        // initing url components
        var components = URLComponents()
        components.scheme = K.PROTOCOL
        components.host = K.HOST_NAME
        components.path = K.TRACKS_PATH
        // init the queries
        components.queryItems = [K.makeQuery(with: track.id!)]
        // if could not form valid url redirect for axenda Link
        guard let linkParameter =  components.url else { return K.AXENDA_ACCOUNT}
        guard let shareLink = DynamicLinkComponents(link: linkParameter, domainURIPrefix: K.DOMAIN_URIPREFIX) else { return K.AXENDA_ACCOUNT }
        // init share link
        // getting bundle id to init share link with it
        if let bundleId = Bundle.main.bundleIdentifier{ shareLink.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleId) }
        // if user do not have the app installed then for now using google params letter on we will use ejadah app
        shareLink.iOSParameters?.appStoreID = K.APP_ID
        // displaying nice url share to people
        shareLink.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        shareLink.socialMetaTagParameters?.title = "\(track.title) من تطبيق اجاده"
        shareLink.socialMetaTagParameters?.descriptionText = track.description
        shareLink.socialMetaTagParameters?.imageURL = K.APP_IMAGE
        
        // shorter link but requires more network call and time
        //        shareLink.shorten { (url, warnings, error) in
        //            if let error = error {
        //                print(error.localizedDescription)
        //                return
        //            }
        //     for learning and better practices
        //            if let warnings = warnings {
        //                print(warnings)
        //            }
        //            guard let url = url else { return }
        //            print("shorten url \(url)")
        //
        //        }
        
        // getting full url
        guard let fullUrl = shareLink.url else { return K.AXENDA_ACCOUNT }
        
        return fullUrl
    }
    
}
