//
//  AddCategoryView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 23/02/2021.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject var viewModel : AddCategoryViewModel
    var body: some View {
        ZStack{
            Color.mainBackground.edgesIgnoringSafeArea(.all)
            VStack{
                OneButtonHeaderView(title:viewModel.addCategory , rightCallBack: viewModel.dismissView , rightIcon: IconsCollection.rightArrow)
                TextField("القسم",text: $viewModel.category.category.title, onCommit: K.dismissKeyBoard )
                    .padding()
                    .frame(width: UIScreen.width / 2.2 * 2 , height: UIScreen.height / 4 * 0.2, alignment: .trailing)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.mainText) )
                    .foregroundColor(.black)
                Button(action:{self.viewModel.callBackPublishButton()}){
                    MainButtonView(title: viewModel.publishButton, width: UIScreen.width / 3)
                        .padding()
                }
                Spacer()
            }
            .alert(item: $viewModel.alertItem){alert in
                // after pressing ok dismiss view 
                Alert(title: alert.title, message: alert.message, dismissButton: .default(Text("حسنا"), action: self.viewModel.dismissView))
            }
            
        }
        .onTapGesture { K.dismissKeyBoard() }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(viewModel: AddCategoryViewModel(dismiss: .constant(false), mode: .constant(false)))
    }
}

