//
//  ButtonUtility.swift
//  David Marro
//
//  Created by David Marro on 28/06/2019.
//  Copyright © 2019 David Marro. All rights reserved.
//

import UIKit

class ButtonUtility: UIViewController {
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var registrazioneButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        
//        let dimensioneFont = labelBenvenuto.font.pointSize
//        let lobsterfont = UIFont.init(name: "Lobster 1.3", size: dimensioneFont)
//        labelBenvenuto.font = Constants.titleFont?.withSize(dimensioneFont)
        
        
        super.viewDidLoad()

        LoginButton.clipsToBounds = true
        LoginButton.layer.shadowColor = UIColor.black.cgColor
        LoginButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        LoginButton.layer.shadowRadius = 2
        LoginButton.layer.shadowOpacity = 0.01
        LoginButton.layer.masksToBounds = false;
        
//        registrazioneButton.layer.cornerRadius = 8
//        registrazioneButton.clipsToBounds = true
        registrazioneButton.layer.shadowColor = UIColor.black.cgColor
        registrazioneButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        registrazioneButton.layer.shadowRadius = 2
        registrazioneButton.layer.shadowOpacity = 0.2
        registrazioneButton.layer.masksToBounds = false;
        
        
//        labelBenvenuto.textColor = Constants.baseAppColor
//        LoginButton.backgroundColor = Constants.baseAppColor
//        registrazioneButton.backgroundColor = Constants.baseAppColor
        
        
        
        
    }
   
    
    
    
    
    
    
    
    
    
    
    
    
/// MARK - Outlets
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
