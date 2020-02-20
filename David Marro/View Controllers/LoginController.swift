//
//  LoginController.swift
//  David Marro
//
//  Created by David Marro on 01/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonIndietro: UIButton!
    //MARK:  - Outlets
    
    @IBOutlet weak var textEmail: UITextField!
    
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var buttonAccedi: UIButton!
    
    
    @IBAction func buttonIndietro(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:  - Setup della schermata

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // arrotondamento angoli text mail
        textEmail.layer.cornerRadius = 5.0
        textEmail.layer.masksToBounds = true
        textEmail.attributedPlaceholder = NSAttributedString(string: "Insert E-mail",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        textPassword.attributedPlaceholder = NSAttributedString(string: "Insert Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])

        // arrotondamento angoli text password - circolare e dinamico in base all altezza
        
        textPassword.layer.cornerRadius = 5.0       //   textPassword.frame.size.height / 2.0
//        textPassword.layer.masksToBounds = true
//        textPassword.layer.borderWidth = 0
        
        textEmail.layer.borderWidth = 0
        textEmail.layer.borderColor = UIColor.black.cgColor
// BUTTON ACCEDI
        buttonAccedi.layer.cornerRadius = 8
        buttonAccedi.clipsToBounds = true
        buttonAccedi.layer.shadowColor = UIColor.black.cgColor
        buttonAccedi.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        buttonAccedi.layer.shadowRadius = 2
        buttonAccedi.layer.shadowOpacity = 0.2
        buttonAccedi.layer.masksToBounds = false;
        
        
//        delegate text field
        textEmail.delegate = self
        textPassword.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    
    
    //    MARK: - Funzioni
    
    private func controllaValiditaDatiInseriti() -> Bool{
// controllo il campo dell'email
        if textEmail.text == nil || textEmail.text == "" {
            AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci la Email", viewController: self)
            print("Devi specificare la Email")
            return false
        }
        if textPassword.text == nil || textPassword.text == "" {
            AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Inserisci la Password", viewController: self)
            print("Devi specificare la password")
            return false
        }
//         tutto ok
        return true

    }
    
    
    //MARK:  - Actions


    
    @IBAction func buttonLogin(_ sender: Any) {
        guard  controllaValiditaDatiInseriti() else {
//             Dati non validi
            return
        }
        
        Network.richiestaLogin(conEmail: textEmail.text, password: textPassword.text) { (utente) in
            if let utente = utente {
//                login riuscito

                
                
                print("Login riuscitooo!!")
                LoginUtility.utenteConnesso = utente
                LoginUtility.salva()
                
                self.performSegue(withIdentifier: "vaiAllaHome", sender: self)
            }else{
                
                print("Login fallito!")
                    AlertUtility.mostraAlertSemplice(titolo: "Errore", messaggio: "Login Fallito!", viewController: self)
                
            }
        }
      
        
    }
//    MARK: -Textfield Delegate
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     if textField == textEmail
     {
//        l utente ha premuto invio su textemail
//        passo al campo password
        textPassword.becomeFirstResponder()
        }
        if textField == textPassword
        {
//            premo invio su password
            resignFirstResponder()
            buttonLogin(textField)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3) {
            var frame = self.view.frame
                    
            //        lo sposto leggermente verso l alto
                    frame.origin.y -= 150
                    self.view.frame = frame
        }

}
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
                var frame = self.view.frame
                        
                //        lo sposto leggermente verso l alto
                        frame.origin.y = 0
                        self.view.frame = frame
    }
        
}
    
    
//    tap recognizer
    
    @IBAction func tapRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
}
