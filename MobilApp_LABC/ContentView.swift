//
//  ContentView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = Controller()
    @State private var showFullMap = false
    @State var selectedAnnotation:PAutomat?
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @State private var shake = false
    var body: some View {
        VStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Text("ParkMate")
                    .foregroundColor(Color("text"))
                    .shadow(radius: 10)
            }
            MapView(selectedAnnotation: $selectedAnnotation, automater:controller.getAutomater())
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    showFullMap = true
                }
        }
        .offset(x: 0, y: -80)
        .frame(width: 450, height: 600)
        .background(LinearGradient(gradient: Gradient(colors: [Color("specialPink"), Color("accent")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        Spacer()
        VStack {
            HStack {
                Button("Hitta Automater"){
                    controller.fetch()
                }
                .buttonStyle(niceButton())
                //.font(.largeTitle)
                //.foregroundColor(Color("specialText"))
                /*Button("Test"){
                    if let url = URL(string: "https://apps.apple.com/se/app/betala-p/id739699373") {
                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                       }
                }*/
            }
            /*VStack {
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
            }*/
        }
        //.offset(x: shake ? -5 : 0)
        //.animation(Animation.default.repeatCount(5).speed(5))
        .onReceive(timer, perform: { _ in
            self.shake.toggle()
        })
        .sheet(isPresented: $showFullMap){
            MapPressedView(automater: controller.getAutomater())
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
