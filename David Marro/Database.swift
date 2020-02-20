//
//  Database.swift
//  David Marro
//
//  Created by David Marro on 20/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import MapKit

class Database: NSObject {
//    lista eventi raggiungibile in qualsiasi punto dell app
    static var eventi: [Evento] = []
    
    static func creaEventiDiProva(){
        let uno = Evento()
        uno.nome = "Lezione App Design"
        uno.indirizzo = "Via Alcamo 11,Roma,Italia"
        uno.descrizione = "Fantastica lezione di App Design"
        uno.data = dateUtility.data(conStringa: "25/05/2019", formato: "dd/MM/yyyy" )
        uno.prezzo = 55.0
        uno.creatore = LoginUtility.utenteConnesso
        uno.immagineUrl = "https://images.unsplash.com/photo-1553531580-652231dae097?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1026&q=80"
        uno.coordinate = CLLocationCoordinate2D(latitude: 41.8864836, longitude: 12.523872)
        eventi.append(uno)
        
        
        
        let due = Evento()
        due.coordinate = CLLocationCoordinate2D(latitude: 50.8864836, longitude: 17.523872)
        due.creatore = LoginUtility.utenteConnesso

        due.nome = "Special Lesson"
        due.indirizzo = "Via Alcamo 11,Roma,Italia"
        due.data = dateUtility.data(conStringa: "05/06/2019", formato: "dd/MM/yyyy" )
        due.prezzo = 10.0
        due.immagineUrl = "https://images.unsplash.com/photo-1542744095-291d1f67b221?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"
        eventi.append(due)
        
        let tre = Evento()
        tre.nome = "Corso Cucito"
        tre.indirizzo = "Viale Marconi 11,Roma,Italia"
        tre.data = dateUtility.data(conStringa: "03/08/2019", formato: "dd/MM/yyyy" )
        tre.prezzo = 30.0
        tre.coordinate = CLLocationCoordinate2D(latitude: 89.8864836, longitude: 12.523872)
        tre.creatore = LoginUtility.utenteConnesso

        tre.immagineUrl = "https://images.unsplash.com/photo-1556793313-2e9460949ddd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"
        eventi.append(tre)
        
        
        let oggettoUno = OggettoAcquistabile()
        let oggettoDue = OggettoAcquistabile()
        
        
        
        oggettoUno.immagineUrl = "https://images.unsplash.com/photo-1553531580-652231dae097?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1026&q=80"
        oggettoUno.nome = "Lezione App Design"
        oggettoUno.quantita = 2
        oggettoUno.prezzo = 100
        
        oggettoDue.immagineUrl = "https://images.unsplash.com/photo-1542744095-291d1f67b221?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"
        oggettoDue.nome = "Special Lesson"
        oggettoDue.quantita = 3
        oggettoDue.prezzo = 7
        
        uno.oggettiAcquistabili = [oggettoUno,oggettoDue]
    }
}
