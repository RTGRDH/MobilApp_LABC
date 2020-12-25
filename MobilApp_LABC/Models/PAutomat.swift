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
    let status: String?
    let pris: Double?
    let tax: Int
    let coordinate: CLLocationCoordinate2D
    init(adress: String?, coordinate: CLLocationCoordinate2D?, status: String?, pris: Double?, tax: Int) {
        self.title = adress
        self.coordinate = coordinate!
        self.status = status
        self.pris = pris
        self.tax = tax
    }
}
