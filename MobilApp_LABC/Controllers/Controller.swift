//
//  Controller.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation

class Controller: ObservableObject{
    let API = fetchFunctions()
    @Published private var PAutomater: [PAutomat] = []
    @Published var isLoading = false
    private let myNotificationKey = "se.challberg.myNotificationKey"
    init(){
        NotificationCenter.default.addObserver(self, selector: #selector(Controller.notificationUpdate), name: NSNotification.Name(rawValue: myNotificationKey), object: nil)
    }
    
    func fetch(){
        isLoading = true
        API.fetchFromApi()
    }
    
    func getAutomater() -> [PAutomat]{
        return PAutomater
    }
    
    @objc func notificationUpdate() -> Void{
        let data = API.getResult()
        updateData(data: data)
    }
    
    private func updateData(data: [PAutomat]){
        DispatchQueue.main.async{
            self.PAutomater = data
            self.isLoading = false
        }
    }
}
