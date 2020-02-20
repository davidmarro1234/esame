//
//  MappaController.swift
//  David Marro
//
//  Created by David Marro on 20/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import MapKit



class MappaController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var buttonCentraPosizioneUtente: UIButton!
    let manager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Mappa Eventi"
        // Do any additional setup after loading the view.
        
        
        
        manager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        
        mapView.delegate = self
        
//        aggiungo i pin sulla mappa
        for evento in Database.eventi{
            let pin = PinMappa.init(conEvento: evento)
            
            mapView.addAnnotation(pin)
        }
        UIUtility.arrotondaAngoliCerchio(buttonCentraPosizioneUtente)
    }
    //    MARK : - MapView delegate
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        Controllo se è stato selezionato un oggetto "PinMappa"
        if let pin=view.annotation as? PinMappa{
            
            if let eventoSelezionato = pin.eventoAssociato{
               
//                calcolo la distanza dell'evento dalla mia posizione
                
                if let miaPosizione = mapView.userLocation.location{
                    
                    let latitudine = eventoSelezionato.coordinate?.latitude ?? 0.0
                    let longitudine = eventoSelezionato.coordinate?.longitude ?? 0.0
                    
                    let posizioneEvento = CLLocation.init(latitude: latitudine, longitude: longitudine)
                    let distanzaInMetri = miaPosizione.distance(from: posizioneEvento)
                    let distanzaInChilometri = distanzaInMetri/1000.0
                    let stringaDistanza = String.init(format: "%.1f",distanzaInChilometri)
                    print("Distanza dell'evento: \(stringaDistanza) metri")
                    
                }
                //        creo la prossima schermata di dettaglio dell'evento
                //        1 prendo un riferimento allo storyboard dove risiede il view controller
                let storyboard = UIStoryboard(name: "Main",bundle: nil)
                //        2 instanzio il v controller attraverso il suo identifier
                let ViewController = storyboard.instantiateViewController(withIdentifier: "DettaglioEventoController")
                //        3 passo l evento selezionato al view controller di dettaglio
                
                if let dettaglioController = ViewController as? DettaglioEventoController{
                    dettaglioController.evento = eventoSelezionato
                    
                    dettaglioController.miaPosizione = mapView.userLocation.location
                    
                }
                
                
                //        4  apro il view controller di dettaglio
                
                navigationController?.pushViewController(ViewController, animated: true)
            
            }
        }
    }
    
    //     MARK: - Actions
    
    @IBAction func buttonCentraPosizioneUtente(_ sender: Any) {
        
       let coordinate = mapView.userLocation.coordinate
        if CLLocationCoordinate2DIsValid(coordinate){
//            controllo che non siamo nell oceano atlantico
            if coordinate.latitude != 0.0, coordinate.longitude != 0
            {
                    mapView.setCenter(coordinate, animated: true)
            }
            
        }
    
    }
    
    
}
