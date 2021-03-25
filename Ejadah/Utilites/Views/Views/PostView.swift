//
//  PostView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 09/01/2021.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var track: TrackService
    var body: some View {
        VStack(spacing:15){
           
            Text(track.track.title)
                .frame(width: 261, alignment: .center)
                .font(Font.custom(K.TajwalFonts.regular, size: 18))
                .foregroundColor(Color.mainText)
                
                
            ZStack {
                Rectangle()
                    .frame(width: 160, height: 30, alignment: .center)
                    .foregroundColor(.durationBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Text("\(track.track.trackDuration) د")
                    .font(Font.custom(K.TajwalFonts.regular, size: 15))
                    .multilineTextAlignment(.center)
                    .frame(width: 180, alignment: .center)
                    .font(.body)
                    .foregroundColor(Color.durationText)
            }
        }
         .accessibility(label: Text("\(track.track.title)\(track.track.trackDuration) د" ))
         .frame(height: 116, alignment: .center)
        .frame(maxWidth: .infinity)
         .background(Color.boxColor)
         .clipShape( RoundedRectangle(cornerRadius: 20) )
        .shadow(radius: 4)
        
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(track: TrackService(track: MockTrackData.postSample))
            .colorScheme(.dark)
          
    }
}
