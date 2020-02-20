//
//  CarrelloController.swift
//  David Marro
//
//  Created by David Marro on 17/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class CarrelloController:UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelCarrelloVuoto: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
        
        
      //    aggiungo pulsante indietro
        let chiudi = UIBarButtonItem.init(title: "Chiudi", style: .plain, target: self, action: #selector(buttonChiudi))
        navigationItem.rightBarButtonItem = chiudi
        setupController()
    }

    func setupController(){
//        configurazione della schermata
        

        
//        messaggio carrello vuoto
        if( CartUtility.carrello.count == 0){
            labelCarrelloVuoto.isHidden = false
        }
        else{
           labelCarrelloVuoto.isHidden = true
        }
        
        //        titolo
        
        if CartUtility.carrello.count > 0{
        let numeroArticoli = CartUtility.carrello.count
        navigationItem.title = "Carrello \(numeroArticoli)"
        }else{
//            carrello vuoto
            navigationItem.title = "Carrello"
        }
        
//        messaggio "nessun articolo nel carrello"
    }
    
    
    
//    MARK - Actions
    
  @objc func buttonChiudi(){
        dismiss(animated: true)
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartUtility.carrello.count
        
        
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCarrello") as! CellCarrello
        
        let oggetto = CartUtility.carrello[indexPath.row]
        cell.setupConOggettoAcquistabile(oggetto)
        
        return cell
        
    }
    
    //     MARK: Editing delle celle della TableView
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        Questa funzione viene richiamata quando l utente cambia la modalità di editing di una cella, tramite lo "swipe-to-delete"
        if editingStyle == .delete {
//             Cancello l'articolo dal carrello
            let oggetto = CartUtility.carrello[indexPath.row]
            CartUtility.rimuoviDalCarrello(oggetto)
            
//            aggiorno la schermata
            setupController()
//            ricarico la table view
            tableView.reloadData()
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
