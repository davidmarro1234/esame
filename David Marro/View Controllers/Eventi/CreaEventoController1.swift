//
//  CreaEventoController1.swift
//  David Marro
//
//  Created by David Marro on 13/01/2020.
//  Copyright © 2020 David Marro. All rights reserved.
//

import UIKit

class CreaEventoController1: UIViewController {

    
    @IBOutlet weak var textNome: UITextField!
    
    
    @IBOutlet weak var textPrezzo: UITextField!
    
    
    @IBOutlet weak var textData: UITextField!
    
    @IBOutlet weak var textIndirizzo: UITextField!
    
    @IBAction func gestureRecognizer(_ sender: Any) {
        
        view.endEditing(true)
        
    }
    
//    MARK: - Variabili Locali
    
    var eventoDaCreare = CreaEvento()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Crea Evento"
        let annulla = UIBarButtonItem.init(title: "Annulla", style: .plain, target: self, action: #selector(buttonAnnulla))
        navigationItem.leftBarButtonItem = annulla

        let datePicker = UIDatePicker()
        
        datePicker.addTarget(self, action: #selector(datePickerModificato(_:)), for: .valueChanged)
        
        
        
        textData.inputView = datePicker
        
        textPrezzo.keyboardType = .decimalPad
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textIndirizzo.text = eventoDaCreare.indirizzio
    }


    @objc func buttonAnnulla(){
          print("Annulla")
          dismiss(animated: true)
      }
    
    @objc private func datePickerModificato(_ datePicker: UIDatePicker){
        print(datePicker.date)
        
        
//        Aggiorno l'evento in fase di creazione
        
        let dataSelezionata = datePicker.date
        eventoDaCreare.data = dataSelezionata
        
//        Aggiorno il campo di testo della data
        let formatoData = "dd/MM/yyyy HH:mm"
        textData.text = dateUtility.stringa(conData: dataSelezionata, formato: formatoData)
        
        
    }

    private func popolaEventoDaCreare(){
        eventoDaCreare.nome = textNome.text
        
        if let stringa = textPrezzo.text, let double = Double(stringa){
        eventoDaCreare.prezzo = double
        }
        if let datePicker = textData.inputView as? UIDatePicker {
            eventoDaCreare.data = datePicker.date
        }
    }
    
    
    private func vaiAllaProssimaSchermata(){
        let next = storyboard?.instantiateViewController(withIdentifier: "CreaEventoController2") as? CreaEventoController2
        
        next?.eventoDaCreare = self.eventoDaCreare
        
        if let next = next {
            navigationController?.pushViewController(next, animated: true)
        }
    }
    
    private func controllaDatiEvento() -> Bool{
    // controllo il campo dell'email
            if textNome.text == nil || textNome.text == "" {
                AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci il nome evento", viewController: self)
//                print("Devi specificare la Email")
                return false
            }
        if (textPrezzo.text == nil || textPrezzo.text == ""  ) {
                     AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci il prezzo evento", viewController: self)
        //                print("Devi specificare la Email")
                        return false
                
                
            }
        if (textData.text == nil || textData.text == ""  ) {
                     AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci data evento", viewController: self)
        //                print("Devi specificare la Email")
                        return false
                

            }
   //                Controllo le coordinate dell'evento
     
        
        if LocationUtility.controlloCoordinate(eventoDaCreare.coordinate) == false {
            AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci un punto dalla mappa interattiva ", viewController: self)
           return false
        }
               
            
    //         tutto ok
        print("allright guys!")
            return true
        
 
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? MappaInterattivaController{
            next.eventoDaCreare = self.eventoDaCreare
        }
    }
    
    @objc func buttonChiudi(){
        dismiss(animated: true)
    }
    
    
    @IBAction func buttonAvanti(_ sender: Any) {
//      1. Verificare che tutti i dati siano corretti
        
//        TODO!!!!
        
        controllaDatiEvento()
//      2. Avvisare l'utente in caso di errori
//         Prendere i dati inseriti dall'utente e metterli nell'oggetto "CreaEvento"
        popolaEventoDaCreare()
        
//        3. Andare avanti alla schermata successiva
        vaiAllaProssimaSchermata()
        
        
    }
    
    
    
    
    
}
