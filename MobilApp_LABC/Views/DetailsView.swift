//
//  DetailsView.swift
//  MobilApp_LABC
//
//  Created by Carl-Bernhard Hallberg on 2020-12-23.
//

import SwiftUI
import MapKit

/*enum Statuses: String {
    let avstängd = "Avstängd"
    let felanmäld = "Felanmäld"
    let iDrift = "I Drift"
    let planerad = "Planerad"
}*/

struct DetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selectedAnnotation: PAutomat?
    @Binding var showDetails: Bool
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
                Text("Parkeringsautomat")
                    .font(.largeTitle)
                    .foregroundColor(Color("accent"))
                    .offset(x: 0, y: 50)
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
                        + Text("\(((selectedAnnotation?.pris ?? 100.0)!), specifier: "%.2f") KR")
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
                    Button("Return"){
                        showDetails = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(niceButton())
                    Button("Vägbeskrivning"){
                        print("Yeet")
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
        Group {
            DetailsView(selectedAnnotation: PAutomat(adress: "Svarta Backen 7", coordinate: CLLocationCoordinate2D(latitude: 51, longitude: 13), status: "I Drift", pris: 100.0), showDetails: .constant(true))
            DetailsView(selectedAnnotation: PAutomat(adress: "Svarta Backen 7", coordinate: CLLocationCoordinate2D(latitude: 51, longitude: 13), status: "I Drift", pris: 100.0), showDetails: .constant(true))
        }
    }
}
