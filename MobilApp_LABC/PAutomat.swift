//
//  ParkViewModel.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import Foundation
import MapKit

final class PAutomat: NSObject, MKAnnotation{
    let title: String?
    let zon: String?
    let pris: Double?
    let coordinate: CLLocationCoordinate2D
  
    init(title: String?, coordinate: CLLocationCoordinate2D?, zon: String?, pris: Double?) {
        self.title = title
        self.coordinate = coordinate!
        self.zon = zon
        self.pris = pris
    }
}
