//
//  ContentView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller = Controller()
    var body: some View {
        VStack{
            Text("ParkMate")
                .foregroundColor(.black)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            MapView(automater:controller.getAutomater())
                .clipShape(Circle())
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .frame(width: 200, height: 200)
            Divider()
                .foregroundColor(.black)
                .padding()
        }
        .background(Color.pink)
        .ignoresSafeArea()
        Spacer()
        Button("Test"){
            print(controller.getAutomater().count)
        }
        Button("I have parked"){
            controller.fetch()
        }
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
