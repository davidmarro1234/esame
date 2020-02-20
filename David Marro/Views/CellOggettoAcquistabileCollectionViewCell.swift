//
//  CellOggettoAcquistabileCollectionViewCell.swift
//  David Marro
//
//  Created by David Marro on 13/05/2018.
//  Copyright © 2018 David Marro. All rights reserved.
//

import UIKit

class CellOggettoAcquistabileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var labelPrezzo: UILabel!
    
    @IBOutlet weak var labelDisponibilità: UILabel!
    
    func setupConOggettoAcquistabile(_ oggetto: OggettoAcquistabile?){

        
        NetworkUtility.downloadImmagine(indirizzoWeb: oggetto?.immagineUrl, perImageView: imageBackground)
        
        labelNome.text = oggetto?.nome
        
        
        if let prezzo = oggetto?.prezzo, prezzo > 0.0{
            labelPrezzo.text = String(format: "%.2f €",prezzo)
        }else{
            labelPrezzo.text = "Gratis"
        }
        
        
        if let quantita = oggetto?.quantita, quantita > 0{
            if quantita > 1{
                labelDisponibilità.text = "\(quantita) disponibile"
            }else{
                labelDisponibilità.text = "\(quantita) disponibili"
            }
        }
            else{
                labelDisponibilità.text = "Nessuna Disponibile"
            }
        }
        
    
}
