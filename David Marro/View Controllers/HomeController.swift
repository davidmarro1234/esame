//
//  HomeController.swift
//  David Marro
//
//  Created by David Marro on 08/04/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class HomeController: UIViewController,UITableViewDelegate,UITableViewDataSource {

//    la lista di eventi da disegnare sulla TableView
    var listaEventi:[Evento] = []
    
//    MARK - Outlets
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lista eventi"

//        let navigationBarAppearance = UINavigationBar.appearance()
//        navigationBarAppearance.barTintColor = .white
        navigationController?.navigationBar.barStyle = .default

        // Do any additional setup after loading the view.
//      serve per comunicare con la table view
        tableView.delegate = self
        tableView.dataSource = self
        
//        aggiornaListaEventi()
        
        aggiungiPulsanteCreaEvento()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        aggiungo \ aggiorno pulsante carrello
        aggiornaListaEventi()

        aggiornaPulsanteCarrello()
        
        
        
        
        
        
    }

    /// MARK: - FUNZIONI
    private func aggiungiPulsanteCreaEvento(){
        
        let icona = UIUtility.iconaBarButton(conNome: "plus2", dimensione: 24, preservaColori: false)
        let button = UIBarButtonItem(image: icona, style: .plain, target: self, action: #selector(apriCreaEvento))
        button.tintColor = .gray
        navigationItem.rightBarButtonItem = button
        
    }
    func aggiornaPulsanteCarrello(){
//        aggiungo aggiorno pulsante carrello
        
        let buttonCarrello = UIBarButtonItem.init(image: CartUtility.iconaCarrello(), style: .plain, target: self, action: #selector(apriCarrello))
        navigationItem.leftBarButtonItem = buttonCarrello
        buttonCarrello.tintColor = .gray
    }
    
    @objc func apriCarrello() {
//        instanzio lo storyboard che contiene il view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "CarrelloController")
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        present(navigationController,animated: true)
    }
    
    @objc func apriCreaEvento() {
        let storyboard = UIStoryboard(name: "Eventi", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "CreaEventoController1")
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController,animated: true)
        
    }
    
    
    //MARK: - Tableview delegate
//    quanti elementi ci sono
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        in questa funzione l'home controller comunica alla TableView il numero di righe che deve disegnare
        
        return listaEventi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        in questa funzione l'home controller comunica alla table view come deve disegnare ogni riga (con quale UI,con quali dati,ecc....)
        let cella = tableView.dequeueReusableCell(withIdentifier: "CellEvento") as! CellEvento
        
        let evento = listaEventi[indexPath.row]
        cella.setupConEvento(evento)
//        index path dice la riga che stiamo visualizzando
        
        
        
        return cella
    }
//    seleziono l evento per il dettaglio
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventoSelezionato = listaEventi[indexPath.row]
        
//        creo la prossima schermata di dettaglio dell'evento
//        1 prendo un riferimento allo storyboard dove risiede il view controller
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
//        2 instanzio il v controller attraverso il suo identifier
                let ViewController = storyboard.instantiateViewController(withIdentifier: "DettaglioEventoController")
//        3 passo l evento selezionato al view controller di dettaglio
        
        if let dettaglioController = ViewController as? DettaglioEventoController{
            dettaglioController.evento = eventoSelezionato
            
        }
        

//        4  apro il view controller di dettaglio
        
        navigationController?.pushViewController(ViewController, animated: true)
    }
    
//    Chiedo la lista eventi aggiornata al server
    func aggiornaListaEventi(){
        Network.richiestaListaEventi {
            (listaEventiAggiornata) in
              self.listaEventi = listaEventiAggiornata ?? []
              self.tableView.reloadData()
//            print(listaEventiAggiornata?.count)
//            print(listaEventiAggiornata?.first?.nome)
        }
    }
}
