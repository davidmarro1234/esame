//
//  MainTabBarController.swift
//  David Marro
//
//  Created by IED Student on 20/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.black
        
        
        if let tabBarItems = tabBar.items {
            
            let dimensioneIcone = CGSize(width: 30.0, height: 30.0)
            
            // HOME
            
            
            if tabBarItems.count >= 1{
                let itemHome = tabBarItems[0]
                
                // Cambio il titolo
                itemHome.title = "Home"
                
                // Cambio l'icona
                let image = UIImage.init(named: "calendar")
                itemHome.image = UIUtility.resizeImage(image, targetSize: dimensioneIcone)
            }
            
            // HOME
            
            if tabBarItems.count >= 2{
                
                let itemMappa = tabBarItems[1]
                
                // Cambio il titolo
                itemMappa.title = "Mappa"
                
                // Cambio l'icona
                let image = UIImage.init(named: "map")
                itemMappa.image = UIUtility.resizeImage(image, targetSize: dimensioneIcone)
            }
            if tabBarItems.count >= 3{
                
                let itemUtente = tabBarItems[2]
                
                // Cambio il titolo
                itemUtente.title = "Utente"
                
                // Cambio l'icona
                let image = UIImage.init(named: "user")
                itemUtente.image = UIUtility.resizeImage(image, targetSize: dimensioneIcone)
                
            }
            
            
            let storyboardAr = UIStoryboard.init(name: "AR", bundle: nil)
            let controllerAR = storyboardAr.instantiateViewController(withIdentifier: "NavigationARCamera")
            //            AR Camera

            viewControllers?.append(controllerAR)
            let itemAR = UITabBarItem()
            controllerAR.tabBarItem = itemAR
            
            itemAR.title = "Camera"
            
            
//            controllerAR.tabBarItem = UITabBarItem()
            let imageAR = UIImage.init(named: "ar")
            itemAR.image = UIUtility.resizeImage(imageAR, targetSize: dimensioneIcone)

            

            
            
        }
        
        
    }
    
}
