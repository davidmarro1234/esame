//
//  AlertUtility.swift
//  David Marro
//
//  Created by David Marro on 17/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class AlertUtility {
    
//    richiamata quando  un utente compie una scelta di conferma (si o no)
    typealias CompletionAlertDiConferma = ((Bool) -> Void)
    
//    mostra un alert di conferma sul view controller
    static func mostraAlertDiConferma(conTitolo titolo: String?,messaggio:  String?,viewController: UIViewController, completion: CompletionAlertDiConferma?){
        
        
//    1.0 Creo l'alert
        
        let alert = UIAlertController.init(title: titolo, message: messaggio, preferredStyle: .alert)
        
//     2.0 Creo l'azione del tasto si
        
       let actionSi =  UIAlertAction.init(title: "Sì", style: .default) {
            (action) in
//            comunico che l utente ha premuto si
            completion?(true)
        }
        
//        2b.  Aggiungo  l'azione all'alert
        
        alert.addAction(actionSi)
        
        
//        3a Creo azione tasto no
        
        let actionNo = UIAlertAction.init(title: "No", style: .cancel) { (action) in
            completion?(false)
        }
        
        alert.addAction(actionNo)
        
        viewController.present(alert,animated: true)
        

        
        
    }
//    Aggiungere completion per la chiusura dell'alert smplice
    
    typealias CompletionAlertSemplice = ( () -> Void )
    
    
    static func mostraAlertSemplice(titolo: String?, messaggio: String?, viewController: UIViewController?, completion: CompletionAlertSemplice? = nil){
        
        
        let alert = UIAlertController(title: titolo, message: messaggio, preferredStyle: .alert)
        
        let actionChiudi = UIAlertAction(title: "Ok",style: .default){
            (action) in completion?()
        }
        alert.addAction(actionChiudi)
        
        viewController?.present(alert,animated: true)

    }

}
