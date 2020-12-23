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
    var body: some View {
        MapView(showingDetails: $showingDetails, selectedAnnotation: $selectedAnnotation, automater: automater)
            .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showingDetails){
            DetailsView(selectedAnnotation: selectedAnnotation, showDetails: $showingDetails)
        }
    }
}

struct MapPressedView_Previews: PreviewProvider {
    static var previews: some View {
        MapPressedView(automater: [], showingDetails: .constant(false))
    }
}

