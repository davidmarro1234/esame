//
//  NetworkParser.swift
//  David Marro
//
//  Created by David Marro on 10/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import CoreLocation

class NetworkParser {
    
    static func parseMeteo(conData data:IEDDictionary) -> Meteo?{
        let meteo = Meteo()
        
        
        if let  main = data["main"] as? IEDDictionary{
            meteo.temperatura = main["temp"] as? Double
        }
        
        if let weather = data["weather"] as? IEDArray {
            if let firstWeather = weather.first{
                meteo.descrizione = firstWeather["description"]  as? String
            }
            
        }
        return meteo
    }
    
    
    
    
    static func parseUtente(conData data:IEDDictionary) -> Utente?{
      
        
            let utente = Utente()
        
        
     
            utente.email = data["email"] as? String
            utente.nome = data["nome"] as? String
            utente.cognome = data["cognome"] as? String
            utente.avatarUrl = data["avatar_url"] as? String
            utente.citta = data["citta"] as? String
            utente.dataNascita = data["data_nascita"] as? String
            utente.id = data["id_utente"] as? Int
            utente.authToken = data["auth_token"] as? String
            
            if let credito = data["credito"] as? Double{
                utente.credito = credito / 100.0
            }
            
        
        return utente
    }

    static func parseListaEventi(con array: IEDArray) -> [Evento]{
//        FIXME: Implementare codice
        var eventi: [Evento] = []
        
        for dictionary in array {
            let evento = parseEvento(con: dictionary)
            eventi.append(evento)
        }
        
//        TODO
//        Parse dei dictionary presenti nell'array JSON degli eventi
        
        
        return eventi
    }
    
    static func parseEvento(con dictionary: IEDDictionary) -> Evento {
        let evento = Evento()

//        Coordinate
        var coordinate = CLLocationCoordinate2D()
        coordinate.latitude = (dictionary["lat"] as? Double) ?? 0
        coordinate.longitude = (dictionary["lat"] as? Double) ?? 0
        evento.coordinate = coordinate
        
       evento.id = dictionary["id"] as?  Int
       evento.nome = dictionary["nome"] as? String
       evento.descrizione = dictionary["descrizione"] as? String
       evento.prezzo = dictionary["prezzo"] as? Double
       evento.immagineUrl = dictionary["cover_url"] as? String
       evento.indirizzo = dictionary["indirizzo"] as? String
        evento.views = dictionary["numero_visualizzazioni"] as? Int
        evento.likes = dictionary["numero_like"] as? Int
//        evento.data = dictionary["timestamp"] as?
//        Data
        let timestamp = dictionary["timestamp"] as? String
        evento.data = dateUtility.data(conStringa: timestamp, formato: "yyyy-MM-dd HH:mm:ss")
        
        if let dictionaryCreatore = dictionary["creatore"] as? IEDDictionary{
            evento.creatore = parseUtente(conData: dictionaryCreatore)
        }
      
       
   

        return evento
    }

}
