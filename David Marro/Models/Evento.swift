//
//  Evento.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import  MapKit
class Evento: OggettoAcquistabile {
    
  
    

    var descrizione: String?
    var indirizzo: String?
    var data: Date?
    var creatore: Utente?
    var likes: Int?
    var views: Int?
    var coordinate: CLLocationCoordinate2D?
    var oggettiAcquistabili: [OggettoAcquistabile]?
}
