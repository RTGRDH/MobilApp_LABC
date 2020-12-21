//
//  APIFetcher.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation

let myNotificationKey = "se.challberg.myNotificationKey"

func fetchFromApi() -> Void{
    
    let web = "http://openstreetgs.stockholm.se/geoservice/api/f8899780-10f5-430b-ac3b-9022a45d3d48/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Parkeringsautomat&outputFormat=Json"
    guard let url = URL(string: web) else { return }
    let req = URLRequest(url: url)
    URLSession.shared.dataTask(with: req) { data, response, error in
        if let data = data{
            if let decodedJson = try? JSONDecoder().decode(PAutomatStruct.self, from: data){
                print(decodedJson.timeStamp)
            }else{
                print("Wtf")
            }
            //NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: nil)
        }else{
            print("Ingen data")
        }
    }.resume()
    
}
