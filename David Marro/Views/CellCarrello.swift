//
//  CellCarrello.swift
//  David Marro
//
//  Created by David Marro on 17/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class CellCarrello : UITableViewCell {
    
    
    
    
    
    
    //        MARK: - Outlets
    @IBOutlet weak var labelNome: UILabel!
    
    
    @IBOutlet weak var labelTipo: UILabel!
    
    
    
    
    //    Mark: - Setup
    
    func setupConOggettoAcquistabile(_ oggetto: OggettoAcquistabile?){
        labelNome.text = oggetto?.nome
        
        
        
        if (oggetto is Evento ){
            labelTipo.text = "Evento"
        } else
        {
            labelTipo.text = "Oggetto"
        }
        
        
        
    }
}
