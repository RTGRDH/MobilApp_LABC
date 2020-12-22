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
                    .foregroundColor(.black)
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
            Divider()
                .foregroundColor(.black)
        }
        .background(Color(red: 245/255, green: 1/255, blue: 121/255).opacity(0.5))
        Spacer()
        VStack {
            Button("I have parked"){
                controller.fetch()
            }
            .font(.largeTitle)
            .foregroundColor(Color(red: 12/255, green: 245/255, blue: 145/255))
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
