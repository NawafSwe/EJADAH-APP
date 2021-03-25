//
//  CategoryView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 03/01/2021.
//

import SwiftUI
struct CategoryView: View {
    @ObservedObject var category: CategoryService
    var body: some View {
        VStack(spacing:5){
            Text(category.category.title)
                .frame(width: 261, alignment: .center)
                .font(Font.custom(K.TajwalFonts.regular, size: 18))
                .foregroundColor(Color.mainText)
                .multilineTextAlignment(.center)
            ZStack {
                Rectangle()
                    .frame(width: 160, height: 30, alignment: .center)
                    .foregroundColor(.durationBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Text("عدد الشروحات: \(category.category.trackNumber)")
                    .font(Font.custom(K.TajwalFonts.regular, size: 15))
                    .multilineTextAlignment(.center)
                    .frame(width: 180, alignment: .center)
                    .font(.body)
                    .foregroundColor(Color.durationText)
                    
                   
            }
            .padding(.top)
        }
        .frame( height: 116, alignment: .center)
        .frame(maxWidth: .infinity)
        .background(Color.boxColor)
        .clipShape( RoundedRectangle(cornerRadius: 20) )
        .shadow(radius: 4)
        .accessibility(label: Text( "\(category.category.title)  عدد الشروحات \(category.category.trackNumber)"))
        
    }
}
struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: CategoryService(category: MockCategoryData.categorySample))
            .colorScheme(.dark)
    }
}
