//
//  UIUtility.swift
//  David Marro
//
//  Created by IED Student on 20/05/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class UIUtility {
    
    static func resizeImage(_ image: UIImage?, targetSize: CGSize) -> UIImage? {
        
        // Controllo se l'immagine passata esiste
        guard let image = image else {
            return nil
            
        }
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func arrotondaAngoliCerchio(_ view: UIView){
        view.layer.cornerRadius = view.frame.size.height / 2.0
        view.layer.masksToBounds = true
    }
    
    static func arrotondaAngoli(_ view: UIView,raggio:  CGFloat){
        view.layer.cornerRadius  = raggio
        view.layer.masksToBounds = true
    }
    
    static func iconaBarButton(conNome nome: String, dimensione: CGFloat,preservaColori: Bool) -> UIImage?{
        let icona = UIImage(named: nome)
        
        let targetSize = CGSize(width: dimensione, height: dimensione)
        let iconaRidimensionata = resizeImage(icona, targetSize: targetSize)
        if preservaColori {
            return iconaRidimensionata?.withRenderingMode(.alwaysOriginal)
        } else{
            return iconaRidimensionata?.withRenderingMode(.alwaysTemplate)
        }
        
        
        
    }
    
}


extension UIColor {
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat, alpha: CGFloat = 1.0){
        self.init(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha : alpha)
        
        
    }
    
    convenience init(hex: String){
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count != 6) {
            
//            return UIColor.gray
            self.init(r: 0, g: 0, b: 0)
            return
            
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
        
    

    
    
    
    
}
