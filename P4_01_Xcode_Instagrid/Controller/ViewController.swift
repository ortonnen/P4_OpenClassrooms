//
//  ViewController.swift
//  P4_01_Xcode_Instagrid
//
//  Created by Nathalie Ortonne on 27/02/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//
/*
 
 3) Associer une action aux boutons du bas qui permet de selectionner une grille.
 Cette action affichera l'image "selected" au click.
 Créer une fonction qui enleve l'image "selected"  aux autres bouttons non sélectionné.

 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBOutlet var buttonView: [UIButton]!
    
    @IBOutlet weak var photo1: UIButton!
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo3: UIButton!
    @IBOutlet weak var photo4: UIButton!
    
    @IBAction func selectLayout1Button() {
    }
    @IBAction func selectLayout2Button() {
    }
    @IBAction func selectLayout3Button(_ sender: Any) {
    }
    
    enum SelectButtonView {
        case view1, view2, view3
    }
    
    func selectButton(view : SelectButtonView) {
        
        switch view {
        case .view1:
            photo2.isHidden = true
        case .view2:
            photo4.isHidden = true
        case .view3:
           break
        }
        
    }
}

