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
    @Binding var showingDetails:Bool
    @State var showRoute: Bool = false
    var body: some View {
        ZStack{
        MapView(showingDetails: $showingDetails, selectedAnnotation: $selectedAnnotation, showRoute: $showRoute, automater: automater)
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showingDetails){
                DetailsView(selectedAnnotation: $selectedAnnotation, showDetails: $showingDetails, showRoute: $showRoute)
            }
            if(showRoute){
                Button("Avbryt Rutt"){
                    print(showRoute)
                    showRoute = false
                }
                .buttonStyle(niceButton())
                .offset(x: 0, y: 285)
                .frame(maxWidth: 250)
            }
        }
    }
}

struct MapPressedView_Previews: PreviewProvider {
    static var previews: some View {
        MapPressedView(automater: [], showingDetails: .constant(false))
    }
}

