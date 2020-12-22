//
//  MapPressedView.swift
//  MobilApp_LABC
//
//  Created by Carl-Bernhard Hallberg on 2020-12-22.
//

import SwiftUI

struct MapPressedView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var automater: [PAutomat]
    @State var selectedAnnotation:PAutomat?
    var body: some View {
        NavigationView{
            MapView(selectedAnnotation: $selectedAnnotation, automater: automater)
                .edgesIgnoringSafeArea(.all)
                .navigationBarItems(trailing: Button("Return"){
                    self.presentationMode.wrappedValue.dismiss()
                }).foregroundColor(.blue)
        }
    }
}
/*
struct MapPressedView_Previews: PreviewProvider {
    static var previews: some View {
        MapPressedView(automater: [])
    }
}
*/
