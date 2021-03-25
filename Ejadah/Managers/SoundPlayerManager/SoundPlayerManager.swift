//
//  SoundPlayerManager.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 06/01/2021.
//

import Foundation
import SwiftUI
import AVKit
// MARK:- SoundPlayerManager
/// final `class` SoundPlayer Manager  using `singleton architecture pattern`
///  class that manages the sound play operations such play, stop, fast forward
final class SoundPlayerManager:ObservableObject {
    //MARK:- Variables
    // audioPlayer for playing sounds
    private var audioPlayer:AVPlayer?
    
    // playerItem for single track
    private var playerItem:AVPlayerItem?
    
    // final CMtimeScale
    private final let CMTimeScale : Int32 = 1000000
    
    // currentTime of sound
    private var currentTime: CMTime = CMTime(seconds: 0, preferredTimescale: 1000000)
    
    // bool to control status of current playing item
    @Published public var isPlaying: Bool = false
    
    // to check and start from the stopping point
    private var isFirstTimePlaying = true
    
    // progressTime for played sound for the progressView
    @Published public var progressTime: TimeInterval = 0.0
    
    // alert item if error occurred
    @Published public var AlertItem:AlertItem?
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published public var fullDuration : TimeInterval = 0.0
    // MARK:- startPlayingSound
    /// start play sound with url from cloud
    /// - Parameter url: sound url that exists in cloud
    /// - returns Void
    func startPlayingSound(with url : String){
        if !isPlaying && isFirstTimePlaying{
            // trying setting up AVFoundation
            do{
                try prepareToPlay(with: url)
                // start playing sound
                audioPlayer?.play()
                // changing status to play
                self.isPlaying = true
                self.isFirstTimePlaying = false
                
            }catch{
                // set alert item
                // if there is an error
                print("error found \(error.localizedDescription)")
                return
            }
        }
        else if !isPlaying && !isFirstTimePlaying{ playSoundAgain() }
        else if isPlaying && !isFirstTimePlaying{ pauseSound() }
    }
    // MARK:- updateCurrentTime
    /// updating the current time for played sound for five seconds
    /// - returns Void
    //@objc
    func updateCurrentTime(){
        // checking if the track downloaded or not may cause nan
        let duration  = CMTimeGetSeconds(self.playerItem!.duration)
        // updating progress view
        if isPlaying{
            if duration > 0.0 {
                DispatchQueue.main.async{
                    self.currentTime = self.playerItem!.currentTime()
                    self.fullDuration = TimeInterval(duration)
                    self.progressTime = CMTimeGetSeconds(self.playerItem!.currentTime())
                }
                // if reach maximum then clear audio session
                if self.currentTime == self.playerItem!.duration { self.clearAudioSession() }
            }
        }
    }
    
    
    //MARK:- fastForward
    /// fast warding played sound
    /// - returns Void
    func fastForward(){
        // getting rid of using optionals
        guard let _ = self.playerItem else{ return }
        guard let _ = self.audioPlayer else { return }
        // getting current time
        var time: TimeInterval = CMTimeGetSeconds(self.playerItem!.currentTime())
        // go forward five seconds forward
        time -= 5.0
        // getting current duration
        let currentDuration: TimeInterval = CMTimeGetSeconds(self.playerItem!.duration)
        if time > currentDuration{
            // if cannot forward pause
            self.audioPlayer!.pause()
        }else{
            // if we can , change time now and seek
            let convertedTime = CMTime(seconds: time, preferredTimescale: self.CMTimeScale )
            // action my be handled differently
            self.audioPlayer!.seek(to: convertedTime){ valid in
                if valid{ DispatchQueue.main.async { self.progressTime =  time } }
            }
            
        }
    }
    
    //MARK:- fastRewind
    /// fast rewind a sound for five seconds
    /// - returns Void
    func fastRewind(){
        // getting rid of using optionals
        guard let _ = self.playerItem else{ return }
        guard let _ = self.audioPlayer else { return }
        // getting current time
        var time:TimeInterval = CMTimeGetSeconds(self.playerItem!.currentTime())
        // go forward five seconds backward
        time += 5.0
        // cannot fast rewind
        if time < 0 {
            // if we cannot pause
            self.audioPlayer!.pause()
        }else{
            // if we can, change time
            let convertedTime = CMTime(seconds: time, preferredTimescale: self.CMTimeScale)
            // action my be handled differently
            self.audioPlayer!.seek(to: convertedTime){ valid in
                if valid{ DispatchQueue.main.async { self.progressTime =  time } }}
        }
        
    }
    //MARK:- clearAudioSession
    /// stopping playing sound
    /// - returns Void
    func clearAudioSession(){
        // clear everything and reset all values
        do{
            try AVAudioSession.sharedInstance().setActive(false)
            self.audioPlayer?.pause()
            DispatchQueue.main.async {
                self.progressTime = 0.0
                self.currentTime = CMTime(seconds: 0.0, preferredTimescale: self.CMTimeScale)
                self.isPlaying = false
                self.isFirstTimePlaying = true
                self.currentTime = CMTime(seconds: 0, preferredTimescale: self.CMTimeScale)
            }
            // cancel timer
            self.timer.upstream.connect().cancel()
        }
        catch{
            print("error \(error.localizedDescription)")
        }
    }
    
    
    /// pause current played sound
    func pauseSound(){
        // is playing is false now
        DispatchQueue.main.async { self.isPlaying = false }
        // stopping audio now
        self.audioPlayer!.pause()
        
    }
    
    /// playing sound from the last point stopped
    func playSoundAgain(){
        let destination = CMTime(seconds: self.progressTime, preferredTimescale: self.CMTimeScale)
        // saving the stopping point for current voice
        self.playerItem?.seek(to: destination){ valid in
            // play sound now
            if valid{
                self.audioPlayer?.play()
                // isPlaying true now
                DispatchQueue.main.async { self.isPlaying = true }
                
            }
        }
    }
    
    /// prepare to play when view appear
    /// - Parameter url: url of hosted sound
    /// - Throws: it may throws an error during initing AVSession
    func prepareToPlay(with url : String)  throws {
        // validating url
        guard let soundURL = URL(string: url) else{
            print("Alert cannot convert given string to url")
            return
        }
        // setting audio player
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        // setting audio session
        try AVAudioSession.sharedInstance().setActive(true)
        // preparing playerItem
        self.playerItem  = AVPlayerItem(url: soundURL)
        self.audioPlayer = AVPlayer(playerItem: self.playerItem)
    }
    
    
    /// updating progress time
    /// - Parameter progressTime: updated progress time
    func updateProgressTime(with progressTime: TimeInterval){
        DispatchQueue.main.async { self.progressTime = progressTime }
    }
    
    /// getting current time of played item
    /// - returns current time in time interval
    func getCurrentTime()->TimeInterval{
        guard let playerItem = self.playerItem else{ return 0.0}
        return CMTimeGetSeconds(playerItem.currentTime())
    }
    
    /// saving content function for testing
    /// - Parameters url: url of the content
    func saveContent(url:String){
        guard let audioUrl = URL(string: url) else {
            print("cannot convert")
            return
            
        }
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationUrl = dir.appendingPathComponent(audioUrl.lastPathComponent)
        if  FileManager.default.fileExists(atPath: destinationUrl.path){
            print("sorry file exists")
        }else {
            
            URLSession.shared.downloadTask(with: audioUrl){(location, response , error) -> Void in
                guard let location = location , error == nil else {
                    print("could not find location")
                    return }
                do{
                    try FileManager.default.moveItem(at: location, to: destinationUrl)
                    print("file moved")
                }catch{
                    print(error)
                }
            }
            .resume()
            
        }
    }
}
