//
//  dateUtility.swift
//  David Marro
//
//  Created by David Marro on 06/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class dateUtility {

//    funzione che converte un oggetto di tipo Date in una Stringa
    
    static func stringa(conData data: Date?, formato: String?) -> String?{
        guard let data = data,let formato = formato else {
            return nil
        }
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = formato
        return formatter.string(from: data)
    }
//    funzione che converte stringa in una data.
    static func data(conStringa stringa: String?, formato: String?) -> Date? {
        
//        controllo valore parametri validi
        guard let stringa = stringa, let formato = formato else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = formato
        return formatter.date(from: stringa)
    }
    
}
