//
//  CreaEventoController4.swift
//  David Marro
//
//  Created by David Marro on 03/02/2020.
//  Copyright © 2020 David Marro. All rights reserved.
//

import UIKit

class CreaEventoController4: UIViewController {

    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var labelCopertina: UIImageView!
    @IBOutlet weak var labelPrezzo: UILabel!
    
    @IBOutlet weak var labelData: UILabel!
    
    @IBOutlet weak var labelIndirizzo: UILabel!
    
    @IBOutlet weak var labelDescrizione: UILabel!
    
    
    var eventoDaCreare: CreaEvento?

    
       override func viewDidLoad() {
           super.viewDidLoad()
        navigationItem.title = "Riepilogo"

//        prezzo = String(prezzo)
        labelNome.text = eventoDaCreare?.nome
        if let prezzo = eventoDaCreare?.prezzo, prezzo > 0.0 {
        labelPrezzo.text = String(format: "%.f € l'ora",prezzo)
            labelData.text = dateUtility.stringa(conData: eventoDaCreare?.data, formato: "dd/MM/yyyy HH:mm")
            labelDescrizione.text = eventoDaCreare?.descrizione
            labelCopertina.image = eventoDaCreare?.copertina
            labelIndirizzo.text = eventoDaCreare?.indirizzio
        
        }
    }
       
    
    
    
    
    
    
    @IBAction func buttonConferma(_ sender: Any) {
        
        Network.richiestaCreaEvento(eventoDaCreare) { (response) in
            if response {
                AlertUtility.mostraAlertSemplice(titolo: "Evento creato con successo", messaggio: nil, viewController: self){
                self.dismiss(animated: true)
                }
            }
        
        else{
            print("Errore")
                AlertUtility.mostraAlertSemplice(titolo: "C'è stato un errore durante la creazione dell'evento", messaggio: nil, viewController: self)
        }
    }
    }
    
//    private func controllaValiditaDatiInseriti() -> Bool{
//    // controllo il campo dell'email
//            if labelNome.text == nil || labelNome.text == "" {
//                AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci la Email", viewController: self)
//                print("Devi specificare il nome dell'evento")
//                return false
//            }
//            if labelPrezzo.text == nil || labelPrezzo.text == "" {
//                AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci la Password", viewController: self)
//                print("Devi specificare il prezzo dell'evento")
//                return false
//            }
//    //         tutto ok
//            return true
//
//        }
    
   


}
