//
//  APIFetcher.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation

let myNotificationKey = "se.challberg.myNotificationKey"

func fetchFromApi() -> Void{
    
    let web = "https://openstreetgs.stockholm.se/geoservice/api/8899780-10f5-430b-ac3b-9022a45d3d48/wfs?service=WFS&version=1.1.0&request=DescribeFeaturetype&typeName=od%3AParkeringsautomat"
    guard let url = URL(string: web) else { return }
    let req = URLRequest(url: url)
    URLSession.shared.dataTask(with: req) { data, response, error in
        if let data = data{
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
             }
            //NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: nil)
        }
    }.resume()
    
}
