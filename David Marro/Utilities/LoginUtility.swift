//
//  LoginUtility.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//
// classe che semplifica l interazione con il database per capire c'è un utente connesso sull'app

import UIKit

class LoginUtility: NSObject {
    
    static var utenteConnesso: Utente? // l'eventuale utente connesso || stiamo creando un utente
    private static let ChiaveUtenteConnesso = "KeyUtenteConnesso"
    
    
    static func salva(){
//        UserDefaults.standard.set(utenteConnesso,forKey: "LoginUtilityKey")
        if let utente = utenteConnesso {
//            c'è un utente connesso da salvare
            
//            converto l'oggetto "utente" in un insieme di byte data
            
            let dataUtente = NSKeyedArchiver.archivedData(withRootObject: utente)
            
            UserDefaults.standard.set(dataUtente, forKey: ChiaveUtenteConnesso)
            
        }else{
            UserDefaults.standard.removeObject(forKey: ChiaveUtenteConnesso)
        }
        
        UserDefaults.standard.synchronize()

    }
    static func carica(){
        let oggettoSalvato = UserDefaults.standard.object(forKey: ChiaveUtenteConnesso)
        if let dataUtente = oggettoSalvato as? Data{
//            ci sono i dati di un utente connesso
            
//            converto i byte "Data" in un oggetto "Utente"
            let utente = NSKeyedUnarchiver.unarchiveObject(with: dataUtente) as? Utente
            
            utenteConnesso = utente
        }else{
            utenteConnesso = nil
        }
    }
}
