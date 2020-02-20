//
//  DettaglioEventoController.swift
//  David Marro
//
//  Crea ted by David Marro on 06/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import MapKit

class DettaglioEventoController: UIViewController,
UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//questo è l evento da rappresentare sulla schermata.
    
    @IBOutlet weak var buttonMappa: UIButton!
    
    var evento: Evento?
    

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var labelCreatore: UILabel!
    var miaPosizione: CLLocation?
    
    @IBOutlet weak var buttonAcquistaBiglietto: UIButton!
    
    @IBOutlet weak var imgCreatore: UIImageView!
    
    @IBOutlet weak var labelDistanza: UILabel!
    
    @IBOutlet weak var imageCopertina: UIImageView!
    
    @IBOutlet weak var labelNome: UILabel!
    
    @IBOutlet weak var labelMeteo: UILabel!
    
    @IBOutlet weak var labelData: UILabel!
    
    @IBOutlet weak var labelPrezzo: UILabel!
    
    @IBOutlet weak var labelIndirizzo: UILabel!
    
    @IBOutlet weak var labelDescrizione: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        metto i contenuti dell evento sui componenti della schermata
        // Do any additional setup after loading the view.
        if let eventoDaRappresentare = evento {
            setupConEvento(eventoDaRappresentare)
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // UI
        
        buttonMappa.setTitle("", for: .normal)
        UIUtility.arrotondaAngoli(buttonAcquistaBiglietto, raggio: 3)
        
        
        
    }
    
    
    
    
    
    func setupConEvento(_ evento: Evento){
        
        
        
        
        
        
//        metto il nome dell evento
        labelNome.text = evento.nome
        if let creatore = evento.creatore {
            labelCreatore.text = evento.creatore?.nomeCompleto
            NetworkUtility.downloadImmagine(indirizzoWeb: evento.creatore?.avatarUrl, perImageView: imgCreatore)
        }
        labelIndirizzo.text = evento.indirizzo
        
        //        metto la data dell'evento
        let data = dateUtility.stringa(conData: evento.data, formato: "dd/MM/yyyy")
        labelData.text = data

        if let prezzo = evento.prezzo, prezzo > 0.0 {
            labelPrezzo.text = String(format: "%.f € l'ora",prezzo)
        }
        else
        {
            //        nessun prezzo specificato
            labelPrezzo.text = "Gratis"
            
        }

        
        labelDescrizione.text = evento.descrizione
//      metto l immagine dell evento
        
        NetworkUtility.downloadImmagine(indirizzoWeb: evento.immagineUrl, perImageView: imageCopertina)
        
//
        if let distanza = LocationUtility.distanza(da: evento.coordinate, a: miaPosizione?.coordinate){
            
            labelDistanza.text = "..."
            let distanzaInChilometri = distanza/1000.0
            
            let stringaDistanza = String.init(format: "%.1f",distanzaInChilometri)
            
            labelDistanza.text = "L'evento è a \(stringaDistanza) km da te!"
            
            
        }else{
            labelDistanza.isHidden = true
        }
        
        
        
        labelMeteo.text = "Caricamento in corso..."
        
        
        
        
        //        metto la temperatura attuale alla posizione dell'evento
        
        
        
        Network.richiestaMeteoEvento(evento) {
//        solo quando riceveo il meteo dal server
            (meteo) in
//metto i dati sulla schermata
            
            if let temperatura = meteo?.temperatura{
                if let descrizione = meteo?.descrizione{
                    self.labelMeteo.text = "\(temperatura)°C - \(descrizione)"
                }
            }
            
        }
        
        
    
//        metto il pin della  Mappa
        
        let pin = PinMappa.init(conEvento: evento)
        mapView.addAnnotation(pin)
        
        if let coordinate  = evento.coordinate{
            let camera = mapView.camera
            camera.centerCoordinate = coordinate
            camera.altitude =  500
        mapView.setCamera(camera, animated: false)
        }
        mapView.showsUserLocation = true
    }
    
    
    
    
    
    
    //    MARK: - CollectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        il numero di celle che deve disegnare la collecion view
        return evento?.oggettiAcquistabili?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cella = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOggettoAcquistabileCollectionViewCell", for: indexPath) as! CellOggettoAcquistabileCollectionViewCell
        
        let oggetto = evento?.oggettiAcquistabili?[indexPath.item]
        
        cella.setupConOggettoAcquistabile(oggetto)
        
        return cella
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        let oggetto = evento?.oggettiAcquistabili?[indexPath.item]
        chiediConfermaAcquisto(oggetto: oggetto)
//        2. se  l  utente accetta lo aggiungiamo al carrello
    }
    
    func chiediConfermaAcquisto(oggetto: OggettoAcquistabile?){
        
        
        guard let oggetto = oggetto else {
            return
            
        }
        
        //        1. mostriamo l alert
        AlertUtility.mostraAlertDiConferma(conTitolo: "Vuoi aggiungerlo al carrello", messaggio: oggetto.nome, viewController: self) {
            (sceltaUtente) in
            if sceltaUtente{
                CartUtility.aggiungiAlCarrello(oggetto)
            }
            
        }
        
        
        
        
    }
    
    
    
    
    //     MARK: - CollectionView layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let altezza =  collectionView.frame.size.height
        
//        larghezza
        
        let larghezzaTotale = collectionView.frame.size.width
        let larghezza = larghezzaTotale * 0.7
        
        return CGSize(width: larghezza, height: altezza)
        
        
    }
/// MARK - Action
    
    @IBAction func mapButton(_ sender: Any) {
        
        AlertUtility.mostraAlertDiConferma(conTitolo: "Vuoi navigare verso l'evento?", messaggio: evento?.indirizzo, viewController: self) { (sceltaUtente) in
            if sceltaUtente {
                LocationUtility.navigaVerso(evento: self.evento)
            }
        }
        
//        LocationUtility.navigaVerso(evento: evento)
    }
    
//
    @IBAction func buttonAcquistaBiglietto(_ sender: Any) {
 chiediConfermaAcquisto(oggetto: evento!)
    }
    
}
