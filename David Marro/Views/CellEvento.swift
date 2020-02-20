//
//  CellEvento.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class CellEvento: UITableViewCell {

    //        MARK: - Outlets

    @IBOutlet weak var labelData: UILabel!
    
    @IBOutlet weak var labelNome: UILabel!
    
    
    @IBOutlet weak var labelIndirizzo: UILabel!
    
    @IBOutlet weak var labelPrezzo: UILabel!
    
    @IBOutlet weak var imageCopertina: UIImageView!

    //    MARK: - Setup della Cella
    
    func setupConEvento(_ evento: Evento){
        UIUtility.arrotondaAngoli(imageCopertina, raggio: 45)

        
//        si occupa di prendere tutte le informazioni dal modello "Evento"  e metterle su ogni elemento grafico della cella (Outlets)
        labelNome.text = evento.nome
        
        labelIndirizzo.text = evento.indirizzo
        if let prezzo = evento.prezzo, prezzo > 0.0 {
        labelPrezzo.text = String(format: "%.f € l'ora",prezzo)
        }
        else
      {
//        nessun prezzo specificato
            labelPrezzo.text = "Gratis"
            
        }
            
            
//    metto l'immagine dell'evento
        NetworkUtility.downloadImmagine(indirizzoWeb: evento.immagineUrl, perImageView: imageCopertina)
        
        
//        metto la data dell'evento
       let data = dateUtility.stringa(conData: evento.data, formato: "dd/MM/yyyy")
        labelData.text = data
    }
    
    
}
