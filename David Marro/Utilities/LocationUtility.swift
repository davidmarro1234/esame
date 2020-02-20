//
//  LocationUtility.swift
//  David Marro
//
//  Created by David Marro on 27/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import MapKit

class LocationUtility {
    
    static func distanza(da: CLLocationCoordinate2D?, a: CLLocationCoordinate2D? ) -> CLLocationDistance?{
//        controlliamo che i dati passati siano validi
        guard let da = da, let a = a else {
            return nil
        }
        guard controlloCoordinate(da), controlloCoordinate(a) else{
            return nil
        }
    

        let locationDa = CLLocation(latitude: da.latitude, longitude: da.longitude)
         let locationA = CLLocation(latitude: a.latitude, longitude: a.longitude)
        return locationDa.distance(from: locationA)
    }
    
    static func navigaVerso(evento: Evento?){
// controllo di avere le coordinate evento
        
        guard let coordinate = evento?.coordinate,controlloCoordinate(coordinate) else {
            return
        }
        
//        Passo le coordinate agli oggetti di sistema per le mappe
        
        let placemark = MKPlacemark.init(coordinate: coordinate)
        let item = MKMapItem.init(placemark: placemark)
        item.name = evento?.nome
//        MKMapItem.openMaps(with: [item],launchOptions: nil)
        item.openInMaps(launchOptions: nil)
        
    }
    
    static func controlloCoordinate(_ coordinate: CLLocationCoordinate2D?) -> Bool{
        guard let coordinate = coordinate else {
            return false
        }
        guard CLLocationCoordinate2DIsValid(coordinate) else{
            return false
        }
        
        guard coordinate.latitude != 0.0, coordinate.longitude != 0.0 else{
            return false
        }
       return true
    }
    
    typealias CompletionIndirizzo = ((String?)->Void)
    
    static func indirizzo(con coordinate: CLLocationCoordinate2D,completion: CompletionIndirizzo?){
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let primoPlacemark = placemarks?.first
            let indirizzo = primoPlacemark?.thoroughfare
            completion?(indirizzo)
        }
    }
    
}
