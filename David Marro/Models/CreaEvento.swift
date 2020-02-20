//
//  CreaEvento.swift
//  David Marro
//
//  Created by iedstudent on 16/12/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import CoreLocation

class CreaEvento {
    
    
    /*
     FLUSSO DI CREAZIONE EVENTO:
     1) NOME, PREZZO DATA (gg , mm , aaaa, indirizzo)
     2) DESCRIZIONE
     3) IMMAGINE DI COPERTINA
    
    nb L 'INSERIMENTO DELLA DATA SARA' CON 3 CAMPI con il date Picker
     nb l'indirizzo avrà un pulsante che aprirà una mappa interattiva, l'utente potrà cliccare sull'inidirzzo
     
     4) pagina riepilogativa.
     
     
    */
    
    
    
    var nome: String?
    
    var descrizione: String?
    var prezzo: Double?
    var copertina: UIImage?
    var latitude: Double?
    var longitude: Double?
    var indirizzio: String?
    
    var data: Date?
}



extension CreaEvento {
    var coordinate: CLLocationCoordinate2D? {
        guard let latitudine = latitude, latitudine  != 0 else {
            return nil
        }
        guard let longitudine = longitude, longitudine  != 0 else {
            return nil

    }
    
        
    return CLLocationCoordinate2D(latitude: latitudine, longitude: longitudine)
    
}
}
