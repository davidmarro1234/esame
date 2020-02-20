//
//  ModificaProfiloController.swift
//  David Marro
//
//  Created by David Marro on 25/11/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class ModificaProfiloController: UIViewController {

    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textCognome: UITextField!

    @IBOutlet weak var textData: UITextField!
    
    @IBOutlet weak var textCitta: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Modifica Profilo Utente"
        
        let annulla = UIBarButtonItem.init(title: "Annulla", style: .plain, target: self, action: #selector(buttonAnnulla))
        navigationItem.leftBarButtonItem = annulla
        
        let salva = UIBarButtonItem.init(title: "Salva", style: .plain, target: self, action: #selector(buttonSalva))
        navigationItem.rightBarButtonItem = salva
        
        if let utenteConnesso = LoginUtility.utenteConnesso{
         configuraSchermataConUtente(con: utenteConnesso)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAnnulla(){
        print("Annulla")
        dismiss(animated: true)
    }
    
    @objc func buttonSalva(){
        print("Salva")
      dismiss(animated: true)
        
        guard let utente = LoginUtility.utenteConnesso else{
            
        return
        }
//        prendo i dati aggiornati prensenti sui campi di testo
        utente.nome = textNome.text
        utente.cognome = textCognome.text
        utente.citta = textCitta.text
        utente.dataNascita = textData.text
        
        Network.richiestaModificaUtente(utente) { (utenteAggiornato) in
            //           controllo se il server ha risposto correttamente

            if let utenteAggiornato = utenteAggiornato{
                utente.authToken = LoginUtility.utenteConnesso?.authToken
            
//            salvo l utente aggiornato sul database
            LoginUtility.utenteConnesso = utenteAggiornato
            LoginUtility.salva()
//            chiudo la schermata di modifica profilo
            self.dismiss(animated: true)
        }else{
                AlertUtility.mostraAlertSemplice(titolo: "Si è verificato un errore!", messaggio: nil, viewController: self)
        }
        }
    }
    
    
    
    func configuraSchermataConUtente(con utente: Utente){
        textNome.text = utente.nome
        textCognome.text = utente.cognome
        textData.text = utente.dataNascita
        textCitta.text = utente.citta
    }



}

