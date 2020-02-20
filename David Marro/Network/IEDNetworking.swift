//
//  IEDNetworking.swift
//  App IED
//
//  Created by Davide Balistreri on 08/02/18.
//  Copyright © 2018 App to you. All rights reserved.
//

import Foundation



/// Da utilizzare quando sul JSON c'è il simbolo "{" (un dictionary)
typealias IEDDictionary = [String: Any]

/// Da utilizzare quando sul JSON c'è il simbolo "[" (un array)
typealias IEDArray = [IEDDictionary]


/**
 * Classe per gestire le chiamate ai servizi web in modo semplificato.
 */





class IEDNetworking {
    
    /// Completion block per restituire la risposta del server alle chiamate web effettuate attraverso questa classe
    typealias IEDNetworkingCompletion = ((IEDNetworkingResponse) -> Void)
    
    
    /// Effettua una chiamata web di tipo "GET" nel formato JSON
    static func jsonGet(url: String, authToken: String?, parameters: [String: Any]?, completion: IEDNetworkingCompletion?) {
        jsonRequest(url: url, requestType: "get", authToken: authToken, parameters: parameters, multipartFiles: nil, completion: completion)
    }
    
    /// Effettua una chiamata web di tipo "POST" nel formato JSON
    static func jsonPost(url: String, authToken: String?, parameters: [String: Any]?, completion: IEDNetworkingCompletion?) {
        jsonRequest(url: url, requestType: "post", authToken: authToken, parameters: parameters, multipartFiles: nil, completion: completion)
    }
    
    static func jsonPut(url: String, authToken: String?, parameters: [String: Any]?, completion: IEDNetworkingCompletion?) {
        jsonRequest(url: url, requestType: "put", authToken: authToken, parameters: parameters, multipartFiles: nil, completion: completion)
    }

    
    /// Effettua una chiamata web di tipo "multipart POST" nel formato JSON
    static func jsonMultipartPost(url: String, authToken: String?, parameters: [String: Any]?, multipartFiles: [IEDNetworkingMultipartFile]?, completion: IEDNetworkingCompletion?) {
        jsonRequest(url: url, requestType: "post", authToken: authToken, parameters: parameters, multipartFiles: multipartFiles, completion: completion)
    }
    
    
    private static func jsonRequest(url urlString: String,
                                    requestType: String,
                                    authToken: String?,
                                    parameters: [String: Any]?,
                                    multipartFiles: [IEDNetworkingMultipartFile]?,
                                    completion: IEDNetworkingCompletion?) {
        
        // Indirizzo web del servizio da richiamare
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        // Creo la richiesta
        var request = URLRequest.init(url: url)
        request.httpMethod = requestType.uppercased()
        
        let boundaryUUID = UUID().uuidString
        let boundaryString = "Boundary-" + boundaryUUID
        
        // Configuro la richiesta per inviargli dei dati in formato JSON
        request.setValue("multipart/form-data; boundary=" + boundaryString, forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let authToken = authToken {
            request.setValue("Token " + authToken, forHTTPHeaderField: "Authorization")
        }
        
        // Inserisco i parametri specificati
        request.httpBody = body(withParameters: parameters, boundaryString: boundaryString, multipartFiles: multipartFiles)
        
        // Creo il task
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Controllo se il server ha restituito qualcosa
            if let data = data {
                do {
                    // Serializzo l'oggetto restituito dal server
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    // Restituisco il messaggio a chi ha chiamato la funzione
                    let responseObject = IEDNetworkingResponse()
                    responseObject.data = jsonObject;
                    responseObject.success = true
                    
                    // Le operazioni di aggiornamento interfaccia vanno eseguite sul thread principale (main)
                    DispatchQueue.main.async {
                        completion?(responseObject)
                    }
                    
                } catch let error {
                    print(error)
                    
                    // Le operazioni di aggiornamento interfaccia vanno eseguite sul thread principale (main)
                    DispatchQueue.main.async {
                        // Restituisco l'errore a chi ha chiamato la funzione
                        completion?(IEDNetworkingResponse())
                    }
                }
            } else {
                // Le operazioni di aggiornamento interfaccia vanno eseguite sul thread principale (main)
                DispatchQueue.main.async {
                    // Restituisco l'errore a chi ha chiamato la funzione
                    completion?(IEDNetworkingResponse())
                }
           }
        }
        
        // Avvio il task
        task.resume()
    }
    
    
    private static func body(withParameters parameters: [String: Any]?, boundaryString: String, multipartFiles: [IEDNetworkingMultipartFile]?) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--" + boundaryString + "\r\n"
        
        if let parameters = parameters {
            for (key, value) in parameters {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\"" + key + "\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        if let multipartFiles = multipartFiles {
            for multipartFile in multipartFiles {
                body.appendString(boundaryPrefix)
                
                if let parameter = multipartFile.parameter, let name = multipartFile.name {
                    body.appendString("Content-Disposition: form-data; name=\"" + parameter + "\"; filename=\"" + name + "\"\r\n")
                }
                
                if let mimeType = multipartFile.mimeType {
                    body.appendString("Content-Type: " + mimeType + "r\n\r\n")
                }
                
                if let data = multipartFile.data {
                    body.append(data)
                }
                
                body.appendString("\r\n")
                body.appendString("--" + boundaryString + "--")
            }
        }
        
        return body as Data
    }
    
}


/**
 * Oggetto restituito in risposta alle chiamate web effettuate attraverso questa classe.
 */
class IEDNetworkingResponse {
    
    /// Indica se la chiamata web effettuata è andata a buon fine.
    var success = false
    
    /// I dati inviati dal server, già convertiti nel formato corretto (es. NSDictionary)
    var data: Any?
    
}


/**
 * Oggetto creato per inviare dei file nel formato multipart.
 */
class IEDNetworkingMultipartFile {
    
    var parameter: String?
    
    var name: String?
    
    var mimeType: String?
    
    var data: Data?
    
    init(parameter: String, name: String, mimeType: String, data: Data) {
        self.parameter = parameter
        self.name = name
        self.mimeType = mimeType
        self.data = data
    }
}


/**
 * Estensione della classe NSMutableData per semplificare la conversione di stringhe in bytes.
 */
extension NSMutableData {
    
    func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            append(data)
        }
    }
    
}
