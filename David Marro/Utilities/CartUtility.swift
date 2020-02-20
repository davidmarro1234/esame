//
//  CartUtility.swift
//  David Marro
//
//  Created by David Marro on 17/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class CartUtility {
    
/// lista oggetti  da acquistare
    static var  carrello: [OggettoAcquistabile] = []
    
/// aggiunge un oggetto al  carrello se  non lo è  stato gia inserito
    static func aggiungiAlCarrello(_ oggetto: OggettoAcquistabile){
        
//        1. Controllare  se  l'oggetto è gia nel carrello
        for  ricercaOggetto in carrello {
            if ricercaOggetto.nome == oggetto.nome{
//                l'oggetto è gia stato aggiunto
                return
            }
        }
            
        
        
        
//        2. aggiungere l'oggetto al carrello
        carrello.append(oggetto)
//        riproduco  un suono
       // Sound.play(file: "service-bell_daniel_simion.wav")
        print("Oggetto aggiunto al carrello!")
    }
    
//    funzione che rimuove un oggetto dal carrello
    
    static func rimuoviDalCarrello(_ oggetto: OggettoAcquistabile) {
//        VERSIONE SWIFT
        if let index = carrello.firstIndex(of: oggetto) {
        carrello.remove(at: index)
        }
        
        
//         VERSIONE OLD STYLE
        
        var counter = 0
        for  ricercaOggetto in carrello {
            if ricercaOggetto.nome == oggetto.nome{
                carrello.remove(at: counter)
                break
            }
            counter += 1
            
        
        }
    }
    
    
    static func iconaCarrello() ->  UIImage? {
        var image: UIImage?
        
        
        if carrello.count > 0{
//        carrello pieno
            image = UIImage(named:"cart_full")
        }
        else{
//            carrello vuoto
             image = UIImage(named:"cart_empty")
        }
        
        image = UIUtility.resizeImage(image, targetSize: CGSize(width:34.0, height: 34.0))
        
        return image
    }

}
