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
    var body: some View {
        VStack{
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Text("ParkMate")
                    .foregroundColor(Color("text"))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            MapView(automater:controller.getAutomater())
                .clipShape(Circle())
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    showFullMap = true
                }
            //Divider()
                //.foregroundColor(.black)
        }
        .frame(width: 450, height: 450)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 245/255, green: 1/255, blue: 121/255).opacity(0.5), Color("accent")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        Spacer()
        VStack {
            Button("Hitta Automater"){
                controller.fetch()
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
