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
    @State private var shake = 2
    var body: some View {
        VStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Text("ParkMate")
                    .foregroundColor(Color("text"))
                    .shadow(radius: 10)
            }
            MapView(automater:controller.getAutomater())
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
            Button("Hitta Automater"){
                controller.fetch()
                shake+=1
            }
            .font(.largeTitle)
            .foregroundColor(Color("specialText"))
        }
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
