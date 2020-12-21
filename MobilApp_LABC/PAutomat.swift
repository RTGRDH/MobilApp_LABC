//
//  ParkViewModel.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation
import MapKit

final class PAutomat: NSObject, MKAnnotation{
    let adress: String?
    let status: String?
    let pris: Double?
    let coordinate: CLLocationCoordinate2D
  
    init(adress: String?, coordinate: CLLocationCoordinate2D?, status: String?, pris: Double?) {
        self.adress = adress
        self.coordinate = coordinate!
        self.status = status
        self.pris = pris
    }
}
