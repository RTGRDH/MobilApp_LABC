//
//  Styles.swift
//  MobilApp_LABC
//
//  Created by Carl-Bernhard Hallberg on 2020-12-23.
//

import SwiftUI
/*
 Inspired/taken by
 https://www.appcoda.com/swiftui-button-style-animation/
 */
struct niceButton: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(Color("accent"))
            .background(LinearGradient(gradient: Gradient(colors: [Color("buttonColor1"), Color("buttonColor2")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
