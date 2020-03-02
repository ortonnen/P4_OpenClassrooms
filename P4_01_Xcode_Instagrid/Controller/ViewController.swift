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

    @IBOutlet weak var buttonLayout1: UIButton!
    @IBOutlet weak var buttonLayout2: UIButton!
    
    @IBOutlet weak var buttonLayout3: UIButton!
    
}

