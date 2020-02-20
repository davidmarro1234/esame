//
//  MappaInterattivaController.swift
//  David Marro
//
//  Created by David Marro on 20/01/2020.
//  Copyright © 2020 David Marro. All rights reserved.
//

import UIKit
import MapKit

class MappaInterattivaController: UIViewController {

    @IBOutlet weak var labelIndirizzoSelezionato: UILabel!

    

    @IBOutlet weak var mapView: MKMapView!
    
let manager = CLLocationManager()
    
//    MARK: Outlets
    
    var eventoDaCreare: CreaEvento?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRecognizer(_:)))
        mapView.addGestureRecognizer(tap)
    }
    
//    viene richiamata quando viene tappato un punto sulla mapview
    @objc private func tapRecognizer(_ sender: UIGestureRecognizer){
        let puntoTappato = sender.location(in: sender.view)
        let coordinateTappate = mapView.convert(puntoTappato, toCoordinateFrom: mapView)
        print(coordinateTappate)
        
        LocationUtility.indirizzo(con: coordinateTappate) { (indirizzoTrovato) in
            print(indirizzoTrovato ?? "Indirizzo Trovato")
            
            self.labelIndirizzoSelezionato.text = indirizzoTrovato ?? "Indirizzo non Trovato"
            
            self.eventoDaCreare?.indirizzio = indirizzoTrovato
            self.eventoDaCreare?.latitude = coordinateTappate.latitude
            self.eventoDaCreare?.longitude = coordinateTappate.longitude
        }
        
        

    }
    
    
}
