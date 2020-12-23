//
//  MapView.swift
//  MobilApp_LABC
//
//  Created by Ernst on 2020-12-16.
//

import SwiftUI
import MapKit
struct MapView: UIViewRepresentable{
    @Binding var showingDetails:Bool
    @Binding var selectedAnnotation:PAutomat?
    /*
     Class to respond to activity from methods in the MapView.
     This class is an delegate of the MapView, when something happens in MapView, the Coordinator gets notified.
     https://www.hackingwithswift.com/books/ios-swiftui/communicating-with-a-mapkit-coordinator
     */
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
               } else if annotation is MapPin {
                  //annotationView.image =  UIImage(imageLiteralResourceName: "Pin")
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
    /*
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
            if view.annotation is MKUserLocation {
                return
            }

            let ibp = view.annotation as? PAutomat
            print(ibp!.adress)
            /*
            ibp_id = (ibp?.court_id)!
            IdentifierCell = "pin_IBP"
            performSegue(withIdentifier: "map_ibp_info", sender: self)
    */
        }
    */
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self,selectedAnnotation: $selectedAnnotation)
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
        uiView.removeAnnotations(automater)
        uiView.addAnnotations(automater)
    }
}
/*
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(selectedAutomat: Binding<PAutomat?>, automater: [])
    }
}
 */
