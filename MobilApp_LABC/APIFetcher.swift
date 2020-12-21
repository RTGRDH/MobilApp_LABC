//
//  APIFetcher.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation
import CoreLocation
import CoordinateTransformationLibrary

class fetchFunctions{
    
    init(){
        resultFromApi = []
    }
    private var resultFromApi: [PAutomat]
    let myNotificationKey = "se.challberg.myNotificationKey"

    let locationManager = CLLocationManager()

    func fetchFromApi() -> Void{
        
        if CLLocationManager.locationServicesEnabled(){
            print(locationManager.location?.coordinate)
            //Lat, Long
        }
        
        let web = "http://openstreetgs.stockholm.se/geoservice/api/f8899780-10f5-430b-ac3b-9022a45d3d48/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Parkeringsautomat&outputFormat=Json"
        guard let url = URL(string: web) else { return }
        let req = URLRequest(url: url)
        URLSession.shared.dataTask(with: req) { [self] data, response, error in
            if let data = data{
                if let decodedJson = try? JSONDecoder().decode(PAutomatStruct.self, from: data){
                    for feature in decodedJson.features{
                        
                        print(feature.geometryName)
                        print(feature.geometry.coordinates)
                        let pos = SWEREF99Position(n: feature.geometry.coordinates[1], e: feature.geometry.coordinates[0], projection: SWEREF99Position.SWEREF99Projection.sweref_99_18_00)
                        let myLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
                        let x = pos.toWGS84()
                        print(x.latitude)
                        print(x.longitude)
                        let test = CLLocation(latitude: 59.337193842903424
                                              , longitude: 17.9386777235112)
                        let automat = CLLocation(latitude: x.latitude, longitude: x.longitude)
                        if(test.distance(from: automat) < 1000){
                            print("KAWABONGA")
                        }
                        //Long Lat Alt (Y X ALT)
                        print("----------------------------------")
                    }
                    
                }else{
                    print("Wtf")
                }
                //NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: nil)
            }else{
                print("Ingen data")
            }
        }.resume()
        
    }
}
