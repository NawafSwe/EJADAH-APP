//
//  TrackModel.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 07/01/2021.
//

import Foundation
import FirebaseFirestoreSwift

//MARK:- TrackModel
/// track model holds all data about particular track
struct PostModel:Codable,Identifiable{
    @DocumentID var id:String?
    var title:String
    var description:String
    var trackURL:String
    var trackDuration:Int
    var isAudio:Bool
    var categoryId:String
    var URLShare:String
}

struct MockTrackData{
    // wav , mp4
    static public let postList : [PostModel] = [
        PostModel( id : "1" , title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://firebasestorage.googleapis.com/v0/b/axenda-clubhub.appspot.com/o/kahild%20(online-audio-converter.com).mp3?alt=media&token=da62e426-a451-4d41-9765-c699fdfc30a5", trackDuration: 100, isAudio: true, categoryId: "ff", URLShare: "" ),
        PostModel( id: "2" , title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://firebasestorage.googleapis.com/v0/b/axenda-clubhub.appspot.com/o/kahild%20(online-audio-converter.com).mp3?alt=media&token=da62e426-a451-4d41-9765-c699fdfc30a5", trackDuration: 100, isAudio: true, categoryId: "", URLShare: "" ),
        PostModel(id: "3", title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://firebasestorage.googleapis.com/v0/b/axenda-clubhub.appspot.com/o/kahild%20(online-audio-converter.com).mp3?alt=media&token=da62e426-a451-4d41-9765-c699fdfc30a5", trackDuration: 100, isAudio: true, categoryId: "", URLShare: "" ),
        PostModel(id:"4", title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://bit.ly/swswift", trackDuration: 100, isAudio: false, categoryId: "", URLShare: ""),
    ]
    static public let postSample: PostModel = PostModel(id: "3", title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://firebasestorage.googleapis.com/v0/b/axenda-clubhub.appspot.com/o/kahild%20(online-audio-converter.com).mp3?alt=media&token=da62e426-a451-4d41-9765-c699fdfc30a5", trackDuration: 100, isAudio: true, categoryId: "" , URLShare: "https://twitter.com/axendateam")
    
    static public let postVideoSample: PostModel = PostModel(id: "3", title: "دورة تدريبيه في الهندسه الصوتيه", description: "لايوجد وصف لهذا الشرح الصوتي", trackURL: "https://firebasestorage.googleapis.com/v0/b/axenda-clubhub.appspot.com/o/kahild%20(online-audio-converter.com).mp3?alt=media&token=da62e426-a451-4d41-9765-c699fdfc30a5", trackDuration: 100, isAudio: false, categoryId: "", URLShare: "" )
}
