//
//  MapView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI
import MapKit
struct MapView: UIViewRepresentable{
    /*
     Class to respond to activity from methods in the MapView.
     This class is an delegate of the MapView, when something happens in MapView, the Coordinator gets notified.
     https://www.hackingwithswift.com/books/ios-swiftui/communicating-with-a-mapkit-coordinator
     */
    class Coordinator:NSObject, MKMapViewDelegate{
        var parent: MapView
        init(_ parent:MapView) {
            self.parent = parent
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    var automater:[PAutomat]
    var locationManager = CLLocationManager()
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.addAnnotations(automater)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {        MapView(automater: [])
    }
}
