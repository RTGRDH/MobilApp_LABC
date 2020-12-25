//
//  MapView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable{
    @Binding var showingDetails: Bool
    @Binding var selectedAnnotation: PAutomat?
    @Binding var showRoute: Bool
    
    var locationManager = CLLocationManager()
    var firstTime: Bool = true
    @State var hasOverlay: Bool = false
    
    var automater:[PAutomat]
    let request = MKDirections.Request() //Request for direction
    /*
     Class to respond to activity from methods in the MapView.
     This class is an delegate of the MapView, when something happens in MapView, the Coordinator gets notified.
     https://www.hackingwithswift.com/books/ios-swiftui/communicating-with-a-mapkit-coordinator
     */
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self,selectedAnnotation: $selectedAnnotation)
    }
    
    
    
    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
        
    /*func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading, uiView: MKMapView) {
        uiView.camera.heading = newHeading.magneticHeading
        uiView.setCamera(uiView.camera, animated: true)
    }*/
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(automater)
        uiView.addAnnotations(automater)
        if(!showRoute && hasOverlay){
            hasOverlay = false
            uiView.removeOverlays(uiView.overlays)
        }
        if(showRoute && selectedAnnotation != nil){
            print("Making route")
            if(hasOverlay){
                hasOverlay = false
                uiView.removeOverlays(uiView.overlays)
            }
            //let source = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))
            let source = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.32, longitude: 18.06))
            let destination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (selectedAnnotation?.coordinate.latitude)!, longitude: (selectedAnnotation?.coordinate.longitude)!))
            request.source = MKMapItem(placemark: source)
            request.destination = MKMapItem(placemark: destination)
            request.transportType = .walking
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
                print("Adding overlay")
                hasOverlay = true
                uiView.addOverlay(route.polyline)
                uiView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    class Coordinator:NSObject, MKMapViewDelegate{
        private var parent: MapView
        @Binding private var selectedAnnotation:PAutomat?
        init(_ parent:MapView, selectedAnnotation: Binding<PAutomat?>) {
            self.parent = parent
            _selectedAnnotation = selectedAnnotation
        }
        /*
         Function to manipulate a annotations appearance on the MapView
         https://www.codementor.io/@muneebali/mapkit-map-pin-and-annotation-11l2dkqvl2
         */
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let Identifier = "Pin"
               let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: Identifier)
            
               annotationView.canShowCallout = true
               if annotation is MKUserLocation {
                  return nil
               } else if annotation is PAutomat {
                  annotationView.image =  UIImage(imageLiteralResourceName: "PinImage")
                  return annotationView
               } else {
                  return nil
               }
            }
        /*
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Pin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPointAnnotationView(annotation: selectedAnnotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else{
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    */
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
            OperationQueue.main.addOperation {
               self.parent.selectedAnnotation = view.annotation as? PAutomat
                print(self.selectedAnnotation?.title ?? "Unknown Address")
                print(self.selectedAnnotation?.status ?? "Unknown Status")
                self.parent.showingDetails = true
            }
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(Color("specialPink"))
            renderer.lineWidth = 5
            return renderer
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(showingDetails: .constant(false), selectedAnnotation: .constant(PAutomat(adress: "Testvägen 7", coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 20), status: "I Drift", pris: 132)), showRoute: .constant(false), automater: [])
    }
}
 
