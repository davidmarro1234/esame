//
//  CreaEventoController2.swift
//  David Marro
//
//  Created by David Marro on 13/01/2020.
//  Copyright © 2020 David Marro. All rights reserved.
//

import UIKit

class CreaEventoController2: UIViewController {

    var eventoDaCreare: CreaEvento?
    
    @IBOutlet weak var textDescrizione: UITextView!
    
    
    @IBAction func buttonAvanti(_ sender: Any) {
        vaiAllaProssimaSchermata()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Descrizione"
        // Do any additional setup after loading the view.
        textDescrizione.becomeFirstResponder()
//        Riporto la descrizione inserita precedentemente
        
        textDescrizione.text = eventoDaCreare?.descrizione
    }
    
    private func popolaEventoDaCreare(){
        eventoDaCreare?.descrizione = textDescrizione.text
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        popolaEventoDaCreare()
    }
    
    private func vaiAllaProssimaSchermata(){
        let next = storyboard?.instantiateViewController(withIdentifier: "CreaEventoController3") as? CreaEventoController3
//
        next?.eventoDaCreare = self.eventoDaCreare
        
        if let next = next {
            navigationController?.pushViewController(next, animated: true)
        }
    }
    


}
