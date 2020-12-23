//
//  ContentView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = Controller()
    @State var selectedAnnotation:PAutomat?
    @State var showingDetails = false
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var shake = false
    var body: some View {
        LoadingView(isShowing: .constant(controller.isLoading)) {
            NavigationView{
                VStack{
                    VStack{
                        Text("ParkMate")
                            .foregroundColor(Color("text"))
                        NavigationLink(destination: MapPressedView(automater: controller.getAutomater(), showingDetails: $showingDetails)){
                            MapView(showingDetails: $showingDetails, selectedAnnotation: $selectedAnnotation, automater:controller.getAutomater())
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                .frame(width: 300, height: 300)
                        }
                    }
                    .offset(x: 0, y: -80)
                    .frame(width: 450, height: 600)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("specialPink"), Color("accent")]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.top)
                    Spacer()
                    HStack {
                        Button("Hitta Automater"){
                            controller.isLoading.toggle()
                            controller.fetch()
                        }
                        .buttonStyle(niceButton())
                    }
                    .offset(x: 0, y: -35)
                    .frame(maxWidth: 380)
                }.ignoresSafeArea()
            }
        }
        
        /*NavigationView {
            VStack{
                Text("ParkMate")
                    .foregroundColor(Color("text"))
                    .shadow(radius: 10)
                NavigationLink(destination: MapPressedView(automater: controller.getAutomater(), showingDetails: $showingDetails)){
                    MapView(showingDetails: $showingDetails, selectedAnnotation: $selectedAnnotation, automater:controller.getAutomater())
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .frame(width: 300, height: 300)
                }
            }
            .offset(x: 0, y: -80)
            .frame(width: 450, height: 600)
            .background(LinearGradient(gradient: Gradient(colors: [Color("specialPink"), Color("accent")]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.top)
        }
        Spacer()
        HStack {
            Button("Hitta Automater"){
                controller.fetch()
            }
            .buttonStyle(niceButton())
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

