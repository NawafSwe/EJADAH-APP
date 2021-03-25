//
//  FileManagerController.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 01/03/2021.
//

import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import SwiftUI


//MARK:- FileManagerViewController
// UIKit bridge to use files inside swiftUI
struct FileManagerViewController:UIViewControllerRepresentable{
    // selected file from files
    @Binding var selectedFile: URL?
    // dismiss view
    @Environment(\.presentationMode) var presentationMode
    
    typealias UIViewControllerType = UIDocumentPickerViewController
    // implementing all coordinator instances
    func makeCoordinator() -> Coordinator {
        // passing the current as parent
        Coordinator(self)
    }
    
    // making the viewController
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        // enabled extensions of files
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.video, .audio] , asCopy: true)
        // setting the delegate
        documentPicker.delegate = context.coordinator
        // selecting file only one a time
        documentPicker.allowsMultipleSelection = false
        // return document picker
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) { }
    
    //MARK:- inner class Coordinator
    class Coordinator : NSObject ,UIDocumentPickerDelegate{
        // defining parent to waiting for selected file we want to capture it
        var parent: FileManagerViewController
        init(_ parent : FileManagerViewController){self.parent = parent}
        
        /// override UIDocumentPickerDelegate func
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else{
                return
            }
            // root dir
            guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            // creating app sand box dir
            let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
            if FileManager.default.fileExists(atPath: sandboxFileURL.path){
                // coping the files
                // means exists on our app sand box
                //do nothing
                self.parent.selectedFile = selectedFileURL
                self.parent.presentationMode.wrappedValue.dismiss()
                
            }else {
                // does not exist
                // coping the files
                self.parent.selectedFile = selectedFileURL
                // dismiss then
                self.parent.presentationMode.wrappedValue.dismiss()
                
            }
        }
    }
}
//MARK:- FileManagerView
// linking the UIKit into SwiftUI
struct FileManagerView:View{
    @Binding var capturedData:URL?
    var body: some View{
        FileManagerViewController(selectedFile: $capturedData)
        
    }
}
