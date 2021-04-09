//
//  AboutUsView.swift
//  ios-AccessibilityApp
//
//  Created by Nawaf B Al sharqi on 25/01/2021.
//

import SwiftUI

// MARK:- AboutUsView
struct AboutUsView: View {
    private let aboutUsTitle = "عن تطبيق منهل"
    private let aboutUsDescription = "التطبيق يوفر شروحات صوتية تساهم في تسهيل حياة الكفيف وأيضاً تساعده على تعلم أهم المهارات التي يحتاجها في حياته اليومية"
    private let team = "فريق العمل"
    private let teamDescription = "اكسندا فريق يطور برمجيات تسهل عملية التعليم"
    var body: some View {
        ZStack {
            // background
            Color.mainBackground
                    .edgesIgnoringSafeArea(.all)
            // main view
            VStack {
                MainHeaderView(title: aboutUsTitle)
                Spacer()

                Text("منهل")
                        .font(Font.custom(K.TajwalFonts.bold, size: 20))
                        .frame(width: UIScreen.width / 3 * 0.9, alignment: .center)
                        .foregroundColor(.durationBackground)

                Text(aboutUsDescription)
                        .modifier(TextModifiers(size: 20, type: K.TajwalFonts.regular, fixedSizeHr: false, fixedSizeVr: true, alignment: .center))
                        .padding(.horizontal)
                        .frame(width: UIScreen.width / 2 * 1.8, alignment: .center)
                        .foregroundColor(.mainText)
                        .accessibility(label: Text(aboutUsDescription))

                // about the team
                VStack(spacing: -12) {
                    Spacer()
                    Text(team)
                            .modifier(TextModifiers(size: 24, type: K.TajwalFonts.bold, fixedSizeHr: false, fixedSizeVr: true, alignment: .center))
                            .foregroundColor(.durationBackground)
                            .frame(width: UIScreen.width / 2 * 0.9, alignment: .center)
                            .accessibility(label: Text(team))

                    Text(teamDescription)
                            .modifier(TextModifiers(size: 20, type: K.TajwalFonts.regular, fixedSizeHr: false, fixedSizeVr: true, alignment: .center))
                            .padding(.horizontal)

                            .frame(width: UIScreen.width / 2 * 1.5, alignment: .center)
                            .foregroundColor(.mainText)
                            .accessibility(label: Text(teamDescription))


                    Link(destination: K.AXENDA_ACCOUNT) {
                        MainButtonView(title: "تواصل معنا")
                    }
                            // can be changed
                            .padding(.bottom)
                            .padding(.top, UIScreen.height / 5 * 0.05)
                            .accessibility(hint: Text("عند ضغط هذا الزر سوف يتم نقلك لصفحه اكسندا على التويتر"))
                    Spacer()
                }
                        .frame(height: UIScreen.height / 3)
                Spacer()
                        .padding(.top)

                Spacer().frame(height: UIScreen.height / 6 * 0.84)
            }
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
                .colorScheme(.dark)

    }
}
