//
//  NetworkUtility.swift
//  IED App 2019
//
//  Created by Davide Balistreri on 26/04/2018.
//  Copyright © 2018 IED. All rights reserved.
//

import UIKit

class NetworkUtility {
    
    static func downloadImmagine(indirizzoWeb: String?, perImageView imageView: UIImageView?) {
        
        // Controllo la validità dei parametri passati alla funzione
        guard let indirizzoWeb = indirizzoWeb, let url = URL.init(string: indirizzoWeb), let imageView = imageView else {
            // Parametri non validi
            return
        }
        
        // Rimuovo l'immagine precedentemente impostata
        imageView.image = nil
        
        // Scarico l'immagine da internet
        DispatchQueue.global().async {
            do {
                // Controllo la validità dei dati inviati dal server
                let data = try Data.init(contentsOf: url)
                
                // Converto i dati in un'immagine
                if let immagine = UIImage(data: data) {
                    
                    // Torno sul thread principale
                    DispatchQueue.main.async {
                        // Assegno l'immagine all'imageView
                        imageView.image = immagine
                    }
                }
            } catch {
                // Si è verificato un errore
                print(error)
            }
        }
    }
    
}
