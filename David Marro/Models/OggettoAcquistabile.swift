//
//  OggettoAcquistabile.swift
//  David Marro
//
//  Created by David Marro on 13/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

/// Classe che definisce la struttura e le proprietà di un oggetto acquistabile ed un evento.

class OggettoAcquistabile: Comparable {
    
    static func < (lhs: OggettoAcquistabile, rhs: OggettoAcquistabile) -> Bool {
        return (lhs.id ?? 0) < (rhs.id ?? 0)
    }
    
    static func == (lhs: OggettoAcquistabile, rhs: OggettoAcquistabile) -> Bool {
        return lhs.nome == rhs.nome
//        return lhs.id == rhs.id
    }
    

    var id: Int?
    
    var nome: String?
    
    var quantita: Int?
    
    var prezzo: Double?
    
    var immagineUrl: String?
    
}
