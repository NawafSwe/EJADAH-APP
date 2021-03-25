//
//  MediaPlayerView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/01/2021.
//

import SwiftUI
import AVKit
//MARK:- MediaPlayerView
struct MediaPlayerView: View {
    //MARK:- States
    @ObservedObject var viewModel: MediaPlayerViewModel
    var body: some View {
        VStack(alignment: .center){
            
            MediaHeaderView(viewModel: self.viewModel)
            
            
            Spacer().frame( height: UIScreen.height / 4 * 0.34, alignment: .center)
            // show video player view if it is not audio
            if !viewModel.track.isAudio{
                VideoPlayerView(viewModel:self.viewModel)
                Spacer()
            }
            
            // show audio player view if it is not video
            else{
                AudioPlayerView(viewModel: self.viewModel)
                Spacer()
            }
        }
        
    }
}
struct PlayerBox_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView(viewModel: MediaPlayerViewModel(track: MockTrackData.postVideoSample , dismiss: .constant(false)))
            .colorScheme(.dark)
    }
}
//MARK:- VideoPlayerView
struct VideoPlayerView: View {
    @ObservedObject var viewModel: MediaPlayerViewModel
    var body: some View {
        VStack(spacing: 20) {
            VideoPlayer(player: AVPlayer(url: URL(string: "\(self.viewModel.track.trackURL)"  )!))
                .frame(width: UIScreen.width - 20, height: UIScreen.height / 3 * 1.2, alignment: .center)
                .background(Color.boxColor)
                .cornerRadius(10)
            VStack(spacing: 30){
                
                Text(viewModel.track.description)
                    .foregroundColor(.mainText)
                    .multilineTextAlignment(.center)
                
                
                // hide it if there is no link
                if !self.viewModel.track.URLShare.isEmpty{
                    Link(destination: URL(string: self.viewModel.track.URLShare)!){ MainButtonView(title: "الرابط المتعلق") }
                    
                }
            }
            .padding(.top)
        }
        
        .frame(width: 414, height: UIScreen.height / 2.5 , alignment: .center)
        
    }
}
//MARK:- AudioPlayerView
struct AudioPlayerView: View {
    @ObservedObject var viewModel: MediaPlayerViewModel
    var body: some View {
        VStack(spacing:40){
            // MARK:- Buttons holder
            VStack(spacing: 40){
                HStack(spacing:60){
                    // FastRewind Button
                    Button(action:{ self.viewModel.soundManager.fastForward() })
                        { FastRewindOrForwardButtonView(text: IconsCollection.fastForward) }
                    
                    
                    // startPlayingSound or stopPlaying
                    Button(action:{ self.viewModel.soundManager.startPlayingSound(with: self.viewModel.track.trackURL) })
                        {  PlayOrPauseAudioButtonView(text: viewModel.isPlaying ? IconsCollection.pauseAudio : IconsCollection.playAudio) }
                    Button(action:{self.viewModel.soundManager.fastRewind() })
                        { FastRewindOrForwardButtonView(text: IconsCollection.fastRewind) }
                }
                
                .padding(.vertical)
                
                // slider
                Slider(value: $viewModel.soundManager.progressTime, in: TimeInterval(0.0)...viewModel.fullDuration, onEditingChanged: { (done) in
                    if done { self.viewModel.soundManager.pauseSound() }
                })
                .frame(width: UIScreen.width - 40, alignment: .center)
                .accentColor(.slider)
                .onReceive(viewModel.soundManager.timer){ _ in
                    //keep updating 
                    self.viewModel.soundManager.updateCurrentTime()
                }
            }
            .frame(width: UIScreen.width - 20, height: UIScreen.height / 3 , alignment: .center)
            .background(Color.boxColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(spacing: 30){
                
                Text(viewModel.track.description)
                    .foregroundColor(.mainText)
                    .multilineTextAlignment(.center)
                
                
                // hide it if there is no link to share
                if !self.viewModel.track.URLShare.isEmpty{
                    Link(destination: URL(string: self.viewModel.track.URLShare)!){
                        MainButtonView(title: "الرابط المتعلق")
                        
                    }
                }
            }
            .padding(.top, 20)
        }
        .frame(width: 414, height: UIScreen.height / 2.5 , alignment: .center)
        .shadow(radius: 2)
        
        .onAppear{ try? self.viewModel.soundManager.prepareToPlay(with: self.viewModel.track.trackURL) }
    }
}

//MARK:- MediaHeaderView
struct MediaHeaderView: View {
    @ObservedObject var viewModel:MediaPlayerViewModel
    var body: some View {
        HStack {
            Button(action:{ self.viewModel.presentActivity.toggle() }){
                // shares the current screen of the app
                ShareButtonView()
                
            }
            .sheet(isPresented: $viewModel.presentActivity){
                if let passedUrl = viewModel.getShareUrl() {
                    UIActivityController(url: passedUrl.absoluteString)
                }
            }
            .accessibility(hint: AccessibilitiesDescription.shareButton.hint)
            .padding(.top)
            .padding(.leading, UIScreen.height / 5 * 0.05)
            Spacer()
            Text(viewModel.track.title)
                .foregroundColor(.mainText)
                .modifier(TextModifiers(size: 24, type: K.TajwalFonts.bold, fixedSizeHr: false, fixedSizeVr: true, alignment: .center))
                .accessibility(label: AccessibilitiesDescription.headerCategoryTitle.label)
                .padding(.top)
                .padding(.horizontal, UIScreen.height / 5 * 0.05)
            Spacer()
            Button(action: {
                self.viewModel.soundManager.clearAudioSession()
                self.viewModel.dismiss.wrappedValue.toggle()
            }){ RightArrowButtonView() }
            .accessibility(hint: AccessibilitiesDescription.backTrack.hint)
            .padding(.top)
            .padding(.trailing, UIScreen.height / 5 * 0.05)
        }
        .padding(.top)
        .padding(.horizontal, UIScreen.height / 6.9 * 0.05)
        .frame(width: UIScreen.width  , height: UIScreen.height / 6.5 * 0.8 , alignment: .center)
        .background(Color.headerColor)
        .edgesIgnoringSafeArea(.top)
    }
}
