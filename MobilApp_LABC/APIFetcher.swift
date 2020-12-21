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

    func getResult() -> [PAutomat]{
        return resultFromApi
    }
    
    func fetchFromApi() -> Void{
        let web = "http://openstreetgs.stockholm.se/geoservice/api/f8899780-10f5-430b-ac3b-9022a45d3d48/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Parkeringsautomat&outputFormat=Json"
        guard let url = URL(string: web) else { return }
        let req = URLRequest(url: url)
        URLSession.shared.dataTask(with: req) { [self] data, response, error in
            if let data = data{
                if let decodedJson = try? JSONDecoder().decode(PAutomatStruct.self, from: data){
                    for feature in decodedJson.features{
                        print(feature.geometryName)
                        print(feature.geometry.coordinates)
                        let automatPos = SWEREF99Position(n: feature.geometry.coordinates[1], e: feature.geometry.coordinates[0], projection: SWEREF99Position.SWEREF99Projection.sweref_99_18_00)
                        let myLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
                        let automatPosWGS84 = automatPos.toWGS84()
                        print(automatPosWGS84.latitude)
                        print(automatPosWGS84.longitude)
                        //let test = CLLocation(latitude: 59.337193842903424
                                              //, longitude: 17.9386777235112)
                        let automat = CLLocation(latitude: automatPosWGS84.latitude, longitude: automatPosWGS84.longitude)
                        if(myLocation.distance(from: automat) < 1000){
                            let naraAutomat = PAutomat(adress: feature.properties.adressbeskrivning, coordinate: CLLocationCoordinate2D(latitude: automat.coordinate.latitude, longitude: automat.coordinate.longitude), status: feature.properties.status.rawValue, pris: 100)
                            resultFromApi.append(naraAutomat)
                        }
                        //Long Lat Alt (Y X ALT)
                        print("----------------------------------")
                    }
                    NotificationCenter.default.post(name: Notification.Name(rawValue: myNotificationKey), object: nil)
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
