//
//  SoundPlayerErrors.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 11/01/2021.
//

import Foundation
import SwiftUI

struct SoundPlayerAlerts{
    static let invalidURL = AlertItem(title: Text("Invalid URL"), message: Text("We are sorry that the url for this track is not working please if the problem persist contact the developer team"), dismissButton: .default(Text("OK")))
    static let cannotPlay = AlertItem(title: Text("Cannot play sound"), message: Text("We are sorry the sound cannot be played please check your connection if the problem persist please contact the developer team"), dismissButton: .default(Text("OK")))
    
    
}

