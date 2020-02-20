//
//  Utente.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

// classe che definisce le proprietà e le azioni dell'entità "Utente" dentro la nostra App.

class Utente : NSObject, NSCoding {
    

    
    
    var authToken: String?  // aggiunto da Postman
    
    
    var id: Int?
    
    var nome: String?
    var cognome: String?
    
    var email: String?
    var password: String?
    var dataNascita: String?    // Postman
    var avatarUrl: String?
    var citta: String?           // Postman
    var credito : Double?        // Postman
    
    
//    MARK: - Protocollo Coding
//    Permette di inizializzare un oggetto "Utente" anche senza un codificatore
    override init() {
        
    }

    func encode(with aCoder: NSCoder) {
//        Codifica
        aCoder.encode(id, forKey: "id")
        aCoder.encode(authToken, forKey: "authToken")
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(cognome, forKey: "cognome")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(dataNascita, forKey: "dataNascita")
        aCoder.encode(citta, forKey: "citta")
        aCoder.encode(credito, forKey: "credito")
        aCoder.encode(avatarUrl,forKey: "avatarUrl")
        
    }

    required init?(coder aDecoder: NSCoder) {
        // Decodifica
        id = aDecoder.decodeObject(forKey: "id") as? Int
        authToken = aDecoder.decodeObject(forKey: "authToken") as? String
        nome = aDecoder.decodeObject(forKey: "nome") as? String
        cognome = aDecoder.decodeObject(forKey: "cognome") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        avatarUrl = aDecoder.decodeObject(forKey: "avatarUrl") as? String
        dataNascita = aDecoder.decodeObject(forKey: "dataNascita") as? String
        citta = aDecoder.decodeObject(forKey: "citta") as? String
        credito = aDecoder.decodeObject(forKey: "credito") as? Double
    }
    
 }


extension Utente{
    var nomeCompleto: String? {
        if let nome = nome, let cognome = cognome {
            return nome + " " + cognome
        } else if let nome = nome{
            return nome
        }else if let cognome = cognome{
            return cognome
        }
    
        return nil
    
    }
}

    
    

