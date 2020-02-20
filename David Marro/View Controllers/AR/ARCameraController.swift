//
//  ARCameraController.swift
//  David Marro
//
//  Created by David Marro on 02/12/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit
import ARKit
import SceneKit


class ARCameraController: UIViewController, ARSCNViewDelegate {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avviaSessione()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interrompiSessione()
    }
    
    
    
    
// MARK: -SETUP
    
    private func avviaSessione(){
//        Avvio modalità AR
        let configuration = ARImageTrackingConfiguration()
//        Creo manualmente la reference image da cercare nel mondo reale
        let image = UIImage.init(named: "ImmagineDemo")!
        let referenceImage = ARReferenceImage.init(image.cgImage!, orientation: .up, physicalWidth: 0.05)
        let image2 = UIImage.init(named: "ImmagineDemo2")!
        let referenceImage2 = ARReferenceImage.init(image2.cgImage!, orientation: .up, physicalWidth: 0.05)

//      La aggiungo alla configurazione AR
        configuration.trackingImages = [referenceImage,referenceImage2]
        configuraSessione()
        sceneView.delegate  = self
        sceneView.session.run(configuration)
    }
    
    
    private func configuraSessione(){
        // Grafica
        sceneView.antialiasingMode = .multisampling4X
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        
        // Tap recognizer per riconoscere quando vengono tappati gli oggetti 3D
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRecognizer(_:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    private func interrompiSessione(){
//        Interrompo la modalità AR
        
        sceneView.session.pause()
    }
    // funzione che viene richiamata quando viene tappato un oggetto sulla sceneView
    @objc private func tapRecognizer(_ sender: UIGestureRecognizer){
        // Prendo la posizione del tocco
        let location = sender.location(in: sender.view)
        
        // Prendo gli oggetti 3D in quella determinata posizione
        let results = sceneView.hitTest(location, options: [.boundingBoxOnly: true])
        
        if let nodeName = results.first?.node.name{
        // E' stato toccato un oggetto 3D
            print("Nodo toccato :\(nodeName)")
            
            //1. Mostrare un allert personalizzato in base all oggetto toccato
            if ( nodeName == "apple" ) {
                AlertUtility.mostraAlertSemplice(titolo: "Attenzione", messaggio: "Hai toccato la mela!", viewController: self)
            }
            else if ( nodeName == "book" ){
                AlertUtility.mostraAlertSemplice(titolo: "Attenzione", messaggio: "Hai toccato il libro!", viewController: self)
            }
            
            
            //2. Mostrare un allert se non viene toccato nessun oggetto
        }else{
            AlertUtility.mostraAlertSemplice(titolo: "Attenzione!!!", messaggio: "Non hai toccato niente!", viewController: self)
        }
    }
    
// MARK: -FUNZIONI PRIVATE
    
    
// MARK: -ASRCNView delegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            
            return
        }
        
        print("Immagine trovata!")
//        Torno sul thread principale
    // controllo quale reference image è stata trovata
        DispatchQueue.main.async {
            if let configuration = self.sceneView.session.configuration as? ARImageTrackingConfiguration{
                
                let trackingImages = Array(configuration.trackingImages)
                if imageAnchor.referenceImage == trackingImages[0]{
                    self.aggiungiLibro(node: node)
                }
                else if imageAnchor.referenceImage == trackingImages[1]{
                    self.aggiungiMela(node: node)
                }
                }
    }
    }
    
    private func aggiungiLibro(node: SCNNode)
    {
        let scene = SCNScene.init(named: "book.scn")
        let bookNode = scene?.rootNode.childNode(withName: "book", recursively: false)
        
        let scaleFactor = 0.05
        bookNode?.scale = SCNVector3(scaleFactor,scaleFactor,scaleFactor)
        // lo sposto leggermente in avanti
        bookNode?.position.y = 0.02
        node.addChildNode(bookNode!)
    }
    
    private func aggiungiMela(node: SCNNode){
        let scene = SCNScene.init(named: "apple.scn")
        let melaNode = scene?.rootNode.childNode(withName: "apple", recursively: false)
        
        let scaleFactor = 0.005
        melaNode?.scale = SCNVector3(scaleFactor,scaleFactor,scaleFactor)
        // lo sposto leggermente in avanti
        melaNode?.position.y = 0.02
                 node.addChildNode(melaNode!)
        
    }
}
