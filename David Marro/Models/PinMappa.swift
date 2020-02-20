//
//  PinMappa.swift
//  David Marro
//
//  Created by David Marro on 20/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import MapKit

// Oggetto creato per poter aggiungere Pin sulla MapView
class PinMappa: NSObject, MKAnnotation {

//    variabili richieste dal protocollo MKANnnotation
    var title: String?
    var subtitle: String?
    var coordinate = CLLocationCoordinate2D()
//    viariabile utilizzata per risalire all evento associato a questo pin
    var eventoAssociato: Evento?
    
    convenience init(conEvento evento: Evento) {
        self.init()

        eventoAssociato = evento
        title = evento.nome
        
        subtitle = evento.indirizzo
        
        if let coordinateEvento = evento.coordinate{

            coordinate = coordinateEvento
        }
    }
}
