//
//  CreaEventoController3.swift
//  David Marro
//
//  Created by David Marro on 27/01/2020.
//  Copyright © 2020 David Marro. All rights reserved.
//

import UIKit

class CreaEventoController3: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var fotoProfilo: UIImageView!
    
    
    var eventoDaCreare: CreaEvento?

    override func viewDidLoad() {
        super.viewDidLoad()
        fotoProfilo.image = eventoDaCreare?.copertina
        navigationItem.title = "Foto Evento"

        // Do any additional setup after loading the view.
    }
    
    
    
    
     private func caricaAvatarDaFotocamera(){
    //            Bisogna inserire sul file info.plist
                
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
        //            Creo il controller della fotocamera
                    let controller = UIImagePickerController()
                    controller.sourceType = .camera
                    controller.delegate = self
                    present(controller,animated: true)
                    
                }
            }
        
    
    
        private func caricaAvatarDaGalleria(){
    //            Bisogna inserire sul file info.plist
                
        //            Creo il controller della fotocamera
                    let controller = UIImagePickerController()
                    controller.sourceType = .photoLibrary
            controller.delegate=self
                    present(controller,animated: true)
                    
                
            
        }
    
    @IBAction func buttonCambiaImmagine(_ sender: Any) {
        //          Chiedo Conferma - Creo l'action Sheet
                let actionSheet = UIAlertController.init(title: "Modifica avatar", message: "Da dove vuoi caricare l'avatar?", preferredStyle: .actionSheet)
        //  Creo l'azione del tasto fotocamera
                let actionFotocamera = UIAlertAction.init(title: "Fotocamera", style: .default) { (action) in
                    
        //            l'utente ha scelto la fotocamera
                    self.caricaAvatarDaFotocamera()
                    
                    
                    
    }
    actionSheet.addAction(actionFotocamera)
    //        creo l'azione del tasto galleria
            let actionGalleria = UIAlertAction.init(title: "Galleria", style: .default) { (action) in
                self.caricaAvatarDaGalleria()
            }
    //        aggiongo l'azione dell'action sheet
    //        creo l'azione del tasto annulla
            
            let actionAnnulla = UIAlertAction(title: "Annulla", style: .cancel)
            actionSheet.addAction(actionGalleria)
            actionSheet.addAction(actionAnnulla)
            present(actionSheet,animated: true)
            
        }
    
    
    
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            if let immagineSelezionata = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
    //            Ok,abbiamo l'immagine scelta o scattata dall'utente
                fotoProfilo.image = immagineSelezionata
                
    //            la invio al server
                    
                eventoDaCreare?.copertina = immagineSelezionata
                
            
            
        }

}
     private func vaiAllaProssimaSchermata(){
            let next = storyboard?.instantiateViewController(withIdentifier: "CreaEventoController4") as? CreaEventoController4
    //
            next?.eventoDaCreare = self.eventoDaCreare
            
            if let next = next {
                navigationController?.pushViewController(next, animated: true)
            }
    }
    
    
    @IBAction func buttonNext(_ sender: Any) {
        vaiAllaProssimaSchermata()

    }
}

