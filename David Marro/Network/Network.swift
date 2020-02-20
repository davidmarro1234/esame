//
//  Network.swift
//  David Marro
//
//  Created by David Marro on 10/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

/**

 Classe che si occupa di gestire  tutte le chiamate ai servizi web esterni dall'app.
 
 */

class Network {
//    chiedi al server il meteo di roma
    static func richiestaMeteoRoma(){
        let url = "http://ied.apptoyou.it/app/meteoroma.php"
        
        IEDNetworking.jsonGet(url: url, authToken: nil, parameters: nil) {
//            viene eseguita quando riceve  risp dal server
            (risposta) in
            if risposta.success{
//                controllo se i dati ricevuti sono del tipo che mi aspettavo
                if let temperatura = risposta.data as? Int{
                    print("La temperatura a Roma è di \(temperatura) °C")
                }
            }
        }
    }
    
    
    typealias CompletionMeteo = ((Meteo?) -> Void)
    
    static  func richiestaMeteoEvento(_ evento: Evento?, completion: CompletionMeteo?) {
//        check validità dei dati
        
        guard let coordinate =  evento?.coordinate else{
// dati non validi
           
            return
        }
        
        
//        indirizzo del servizio web da richiamare
        let url = "http://ied.apptoyou.it/app/weather.php"
//        parametri da passare  al servizio
        var parametri=IEDDictionary()
        parametri["appid"]="7854e283b3c65ba9943d850e002019b4"
        parametri["units"]="metric"
        parametri["lang"]="it"
        
        parametri["lat"] = coordinate.latitude
        parametri["lon"] = coordinate.longitude
        
//        richiamo il servizio
        
        IEDNetworking.jsonGet(url: url, authToken: nil, parameters: parametri) {
//            eseguita quando riceve risposta dal server
            (risposta) in
            if risposta.success{
                if let dictionary = risposta.data as? IEDDictionary{
//                    parse della risposta
                    let meteo = NetworkParser.parseMeteo(conData: dictionary)
                    completion?(meteo)
                    print("la temperatura  è: \(meteo?.temperatura ?? 0)")
                    print("la descrizione  è: \(meteo?.descrizione ??  "")")
                    
                }


            }
        }
    }
    
    
    
    typealias CompletionLogin = ((Utente?) -> Void)
    
    static func richiestaLogin(conEmail email: String?, password: String?, completion: CompletionLogin?){
//        controllo la validita dei dati
        guard let email = email, let password = password else {
//            Dati non validi
            completion?(nil)
            return
        }
//        indirizzo del servizio web da richiamare
        let url = "http://ied.apptoyou.it/app/login.php"
        
//        parametri da passare al servizio
        var parametri = IEDDictionary()
        parametri["email"]=email
        parametri["password"]=password
        IEDNetworking.jsonPost(url: url, authToken: nil, parameters: parametri) { (risposta) in
            if risposta.success{
//              controllo se il server ha inviato i dati che mi aspettavo
                    if let data = risposta.data as? IEDDictionary{
                        if let datiUtente = data["data"] as? IEDDictionary{
//                            login Riuscito
                            let utente = NetworkParser.parseUtente(conData: datiUtente)
                            
//                            restituisco l oggetto alla funzione chiamante
                            
                            completion?(utente)
                            
                            return
                        }
        }
    }

//                login fallito
                completion?(nil)
            
        }
    }
    
    
//    typealias CompletionLogin = utente -> Void
//     MARK: - Modifica Avatar
    typealias CompletionModificaAvatar = ((Bool) -> Void)
    
    static func richiestaModificaAvatarUtenteConnesso(nuovoAvatar: UIImage, completion: CompletionModificaAvatar?){
        
        let url = "http://ied.apptoyou.it/app/modifica_avatar.php"
        let dataAvatar = nuovoAvatar.jpegData(compressionQuality: 1.0)!
        let fileAvatar = IEDNetworkingMultipartFile.init(parameter: "avatar", name: "avatar.jpg", mimeType: "image/jpg", data: dataAvatar)
//        prendo il token dell utente connesso
        let authToken = LoginUtility.utenteConnesso?.authToken
        
        
        IEDNetworking.jsonMultipartPost(url: url, authToken: authToken , parameters: nil, multipartFiles: [fileAvatar]) { (response) in
            
//            controllo se la richiesta è andata a buon fine
            if response.success {
                completion?(true)
            }else{
                completion?(false)
            }
            
        }
        
    }

//    MARK- Utente connesso
    
    typealias CompletionUtente = ((Utente?) -> Void)
    
    static func richiestaUtenteConnesso(completion: CompletionUtente?){
// Fare in modo che all apertura della schermata del profilo dell utente connesso, venga stampato l indirizzo corretto avatar_url sulla console
        let url = "http://ied.apptoyou.it/app/utente.php"
        let authToken = LoginUtility.utenteConnesso?.authToken

        IEDNetworking.jsonGet(url: url, authToken: authToken, parameters: nil) { (response) in
            print(response)
                if let data = response.data as? IEDDictionary{
                    if let datiUtente = data["data"] as? IEDDictionary{
//                            login Riuscito
                        let utente = NetworkParser.parseUtente(conData: datiUtente)
                        
//                            restituisco l oggetto alla funzione chiamante
                        
                        completion?(utente)
                        
                        return
                    }
        }
        
        
    }
//        Richiesta fallita
        completion?(nil)


}
    
        static func richiestaModificaUtente(_ utente: Utente, completion: CompletionUtente?){
    //        codice
//            la richiesta  è una json put su questo indirizzo
//
            let url = "http://ied.apptoyou.it/app/modifica_utente.php"
            let authToken = LoginUtility.utenteConnesso?.authToken
            var parameters = IEDDictionary()
//            parameters["_method"] = "PUT"
            parameters["nome"]=utente.nome
        
            parameters["cognome"]=utente.cognome
            parameters["citta"]=utente.citta
            parameters["data_nascita"]=utente.dataNascita
//            let dataImage = foto.jpegData(compressionQuality: 1.00)
            
                
                
                
                
                
                
            IEDNetworking.jsonPost(url: url, authToken: authToken, parameters: parameters) { (response) in
                if response.success {
                    
                    completion?(utente)
                }else{
//                    completion?(false)
                }
              
            
//            vanno passati al servere i parametri dei campi da modificare
        }

   
            
            
}
    typealias CompletionListaEventi = (([Evento]?) -> Void)
       
       static func richiestaListaEventi (completion: CompletionListaEventi?){
        

        //        indirizzo del servizio web da richiamare
                let url = "http://ied.apptoyou.it/app/api/eventi.php"
                
        //        parametri da passare al servizio

          IEDNetworking.jsonGet(url: url, authToken: nil, parameters: nil) { (response) in
                    print(response)
            if response.success{
                if let data = response.data as? IEDDictionary{
                if let datiEventi = data["data"] as? IEDArray{
                    let listaEventi = NetworkParser.parseListaEventi(con: datiEventi)
                    completion?(listaEventi)
//                    print(datiEventi)
                return
                    }
                }
    }
        //        Richiesta fallita
                completion?(nil)


        }
        
    
            
    
}
    
    typealias CompletionCreaEvento = ((Bool) -> Void)
    
    static func richiestaCreaEvento(_ eventoDaCreare: CreaEvento?, completion: CompletionCreaEvento? ){
//        prendere immagine copertina dell'evento
//        inviarla come parametro al server: il nome del parametro è "cover" (modifica avatar immagine)
      let url = "http://ied.apptoyou.it/app/api/evento.php"
      let authToken = LoginUtility.utenteConnesso?.authToken
      var parameters = IEDDictionary()
//            parameters["_method"] = "PUT"
    parameters["nome"] = eventoDaCreare?.nome
    parameters["descrizione"]=eventoDaCreare?.descrizione
    parameters["prezzo"]=eventoDaCreare?.prezzo
    parameters["indirizzo"]=eventoDaCreare?.indirizzio
        parameters["lat"]=eventoDaCreare?.latitude
        parameters["lng"]=eventoDaCreare?.longitude
        if let cover = eventoDaCreare?.copertina{
            
            let dataImage = cover.jpegData(compressionQuality: 1.00)
            let fileImage = IEDNetworkingMultipartFile.init(parameter: "cover", name: "copertina.jpg", mimeType: "image/jpg", data: dataImage!)
            
            IEDNetworking.jsonMultipartPost(url: url, authToken: authToken, parameters: parameters, multipartFiles: [fileImage]) { (response) in
                if response.success {
                                   completion?(true)
                                   
                               }
                                else
                               {
                                   completion?(false)
                               }
                            }
           
        }else{
                    IEDNetworking.jsonPost(url: url, authToken: authToken, parameters: parameters) { (response) in
                        if response.success {
//
                            completion?(true)
                        }else{
                            completion?(false)
                        }
    }
    
    
}

}

}
