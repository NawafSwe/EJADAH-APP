//
//  AddPostView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 19/02/2021.
//

import SwiftUI

struct AddPostView: View {
    @ObservedObject var
        viewModel:AddPostViewModel
    init(viewModel:AddPostViewModel ) {
        self.viewModel = viewModel
        UITextView.appearance().backgroundColor = .clear
        
    }
    var body: some View {
        ZStack{
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack {
                OneButtonHeaderView(title: viewModel.getHeaderTitle(), rightCallBack: viewModel.dismissView, rightIcon: IconsCollection.rightArrow)
                ScrollView {
                    VStack(spacing: 20){
                        VStack(alignment: .trailing) {
                            Text(viewModel.titleFieldLabel)
                                .font(Font.custom(K.TajwalFonts.regular, size: 18))
                                .foregroundColor(.mainText)
                            
                            TextField("العنوان", text: $viewModel.post.track.title , onCommit:viewModel.toggleKB)
                                .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2, alignment: .trailing)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                                .foregroundColor(.black)
                        }
                        
                        // customized picker instead of text filed
                        VStack (alignment: .trailing){
                            Text(viewModel.categoryLabel)
                                .font(Font.custom(K.TajwalFonts.regular, size: 18))
                                .foregroundColor(.mainText)
                            HStack{
                                Text("\(viewModel.category.title)")
                                    .padding(.trailing)
                                    .foregroundColor(.black)
                            }
                            .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2, alignment: .trailing)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                            
                            
                        }
                        VStack (alignment: .trailing) {
                            Text(viewModel.descriptionLabel)
                                .font(Font.custom(K.TajwalFonts.regular, size: 18))
                                .foregroundColor(.mainText)
                                .padding(.horizontal)
                            TextEditor(text: $viewModel.post.track.description)
                                .font(Font.custom(K.TajwalFonts.light, size: 24))
                                .frame(width: UIScreen.width / 2 * 1.9, height: UIScreen.height / 5 * 0.8, alignment: .center)
                                .background(Color.mainText )
                                .foregroundColor(.black)
                                .cornerRadius(15)
                            
                            
                            
                        }
                        
                        VStack (alignment: .trailing , spacing: 20){
                            VStack (alignment: .trailing){
                                Text(":\(viewModel.relatedLinkPlaceholder)")
                                    .font(Font.custom(K.TajwalFonts.regular, size: 18))
                                    .foregroundColor(.mainText)
                                TextField(viewModel.relatedLinkPlaceholder, text: $viewModel.post.track.URLShare , onCommit: viewModel.toggleKB)
                                    .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2, alignment: .trailing)
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                                    .foregroundColor(.black)
                            }
                            
                          
                                if viewModel.mode.wrappedValue{
                                    viewModel.getDeleteButton()
                                    
                                }else{
                                    viewModel.getPublishButton()
                                        .sheet(isPresented: $viewModel.showDocuments , onDismiss:self.viewModel.setImportedFileName){ FileManagerView(capturedData: $viewModel.data) }
                                        .padding(.trailing , -15)
                                    
                                }
                                
                                Text(self.viewModel.importedFileName)
                            }
                           

                        }
                            Button(action:{ self.viewModel.secondaryCallBack() }){
                                MainButtonView(title: viewModel.secondaryButtonTitle, width: UIScreen.width / 4, height: UIScreen.height/4 * 0.21)
                            }
                            
                        
                        
                        
                        Spacer()
                    }
                    Spacer()
                }
            .onTapGesture { viewModel.toggleKB() }
            }
            .alert(item: $viewModel.alertItem){alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            .edgesIgnoringSafeArea(.all)
            .disabled(viewModel.isLoading)
            if viewModel.isLoading{
                LoadingView(fileName: K.Files.uploadLoading, isLoading: $viewModel.isLoading)
            }
            
            
        }
    }

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(viewModel: AddPostViewModel(category: MockCategoryData.categorySample, dismiss: .constant(false) , mode: .constant(false)))
    }
}

//MARK:- PlaceholderModifier
struct PlaceholderModifier:ViewModifier{
    var showPlaceholder:Bool
    var placeHolder:String
    func body(content: Content) -> some View {
        ZStack{
            if showPlaceholder{
                Text(placeHolder)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            content
                .foregroundColor(Color.mainText)
                .padding(.horizontal)
                .overlay(Rectangle().foregroundColor(.white))
            
        }
    }
}

