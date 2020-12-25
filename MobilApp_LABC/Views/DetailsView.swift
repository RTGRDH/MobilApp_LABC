//
//  DetailsView.swift
//  MobilApp_LABC
//
//  Created by Carl-Bernhard Hallberg on 2020-12-23.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedAnnotation: PAutomat?
    @Binding var showDetails: Bool
    @Binding var showRoute: Bool
    @State var statusColor: Color = .red
    
    private func checkColor(status: String){
        if(status == "I Drift"){
            statusColor = .green
        }else if(status == "Planerad"){
            statusColor = .yellow
        }
        else{
            statusColor = .red
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Parkerings Automat")
                    .font(.largeTitle)
                    .foregroundColor(Color("accent"))
                    .offset(x: 0, y: 50)
                Rectangle().frame(width: 285, height: 2, alignment: .center)
                    .offset(x: 0, y: 30)
                    .foregroundColor(Color("accent"))
                Spacer()
                VStack(alignment: .leading, spacing: 50){
                    Text("Adress: ")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    + Text("\(selectedAnnotation?.title ?? "Okänd Adress")")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    Text("Status: ")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    + Text("\(selectedAnnotation?.status ?? "Okänd Status")")
                        .font(.title)
                        .foregroundColor(statusColor)
                    Text("Pris: ")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    + Text("\(((selectedAnnotation?.pris ?? 100.0)!), specifier: "%.2f") KR/H")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    Text("Taxa typ: ")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    + Text("\(selectedAnnotation?.tax ?? 0)")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    Text("Operatör: ")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                    + Text("Betala-P Stockholm")
                        .font(.title)
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                VStack {
                    Button("Returnera"){
                        showDetails = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(niceButton())
                    Button("Vägbeskrivning"){
                        showRoute = true
                        print(selectedAnnotation?.title ?? "Okänd Adress")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(niceButton())
                    Button("Öppna Applikation"){
                        if let url = URL(string: "https://apps.apple.com/se/app/betala-p/id739699373") {
                              UIApplication.shared.open(url, options: [:], completionHandler: nil)
                           }
                    }
                    .buttonStyle(niceButton())
                }.offset(x: 0, y: -35)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("specialPink"), Color("accent")]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }.onAppear(perform: {
            checkColor(status: selectedAnnotation?.status ?? "Okänd Status")
        })
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(selectedAnnotation: .constant(PAutomat(adress: "Svarta Backen 7", coordinate: CLLocationCoordinate2D(latitude: 51, longitude: 13), status: "I Drift", pris: 100.0, tax: 2)), showDetails: .constant(true), showRoute: .constant(false))
        
    }
}

