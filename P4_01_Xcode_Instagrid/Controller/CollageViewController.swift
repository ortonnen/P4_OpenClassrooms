//
//  ViewController.swift
//  P4_01_Xcode_Instagrid
//
//  Created by Nathalie Ortonne on 27/02/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//
/*

 */

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        basicViewGridCollection()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeSwipeLabelAndArrow()
    }
    
    let image = UIImagePickerController()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
   
    @IBOutlet var screenView: UIView!
    @IBOutlet var selectViewbutton: [UIButton]!
    
    @IBOutlet weak var squarePhotoViewTopLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewTopRightButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomRightButton: UIButton!
    
    @IBAction func tapToChangePhotoButton(_ sender: UITapGestureRecognizer) {
        choosePhotoInLibrary ()
        changePhoto()
    }
    
    private func choosePhotoInLibrary () {
      //UIImagePickers
    }
    
    private func changePhoto () {
        //squarePhotoViewButton.imageView.isHidden = true
        //squarePhotoViewButton.background = image
        // if / else
    }
    
    
    @IBAction func selectRectangleTopViewButton() {
        selectGridCollection()
        selectButton(view: .firstView)
    }
    
    @IBAction func selectRectangleBottomViewButton() {
        selectGridCollection()
        selectButton(view: .secondView)
    }
    
    @IBAction func selectSquareViewButton() {
        selectGridCollection()
        selectButton(view: .thirdView)
    }
    
    enum GridLayoutView {
        case firstView, secondView, thirdView
    }
    
    private func selectButton(view : GridLayoutView) {
        
        switch view {
        case .firstView:
            squarePhotoViewTopLeftButton.isHidden = false
            squarePhotoViewTopRightButton.isHidden = true
            squarePhotoViewBottomLeftButton.isHidden = false
            squarePhotoViewBottomRightButton.isHidden = false
        case .secondView:
            squarePhotoViewTopLeftButton.isHidden = false
            squarePhotoViewTopRightButton.isHidden = false
            squarePhotoViewBottomLeftButton.isHidden = false
            squarePhotoViewBottomRightButton.isHidden = true
        case .thirdView:
            squarePhotoViewTopLeftButton.isHidden = false
            squarePhotoViewTopRightButton.isHidden = false
            squarePhotoViewBottomLeftButton.isHidden = false
            squarePhotoViewBottomRightButton.isHidden = false
        }
    }
    
    private func selectGridCollection () {
        for button in selectViewbutton {
            if button.isSelected == true {
                button.imageView?.isHidden = false
            } else {
                button.imageView?.isHidden = true
            }
        }
    }
    
    private func basicViewGridCollection () {
        selectButton(view: .secondView)
        selectViewbutton[0].imageView?.isHidden = true
        selectViewbutton[1].imageView?.isHidden = false
        selectViewbutton[2].imageView?.isHidden = true
    }

    @objc func swipeScreen (_ sender : UISwipeGestureRecognizer) {
        transformSwipeView(gesture: sender, orientation: UIDevice.current.orientation)
    }
    
    private func transformSwipeView ( gesture : UISwipeGestureRecognizer, orientation : UIDeviceOrientation) {
        //Le swipe lance une animation qui fait glisser la grille principale vers le haut (ou vers la gauche) jusqu’à disparaître de l’écran.
        let swipeUp = CGAffineTransform(translationX: 0, y: screenHeight)
        let swipeLeft = CGAffineTransform(translationX: screenWidth, y: 0)

        if gesture.direction == .up && orientation.isPortrait == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.screenView.transform = swipeUp
            }, completion: nil)
            
        } else if gesture.direction == .left && orientation.isLandscape == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.screenView.transform = swipeLeft
            }, completion: nil)
        }
        shareImage()
    }
    
    private func shareImage () {
        //Une fois l’animation terminée, la vue ​UIActivityController s’affiche et permet à l’utilisateur de choisir son application préférée pour partager sa création.
        let contentToShare = [image]
        UIActivityViewController(activityItems: [contentToShare], applicationActivities:[])
    }

    private func sharingFinished () {
    //Une fois le partage effectué, annulé ou échoué, la grille principale revient automatiquement à sa place d’origine par l’animation inverse.
    }
   
    @IBOutlet weak var arrowLeft: UIImageView!
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    
    private func changeSwipeLabelAndArrow () {
        // change text of swipe Label and arrow orientation
        
        if UIDevice.current.orientation.isPortrait {
            swipeLabel.text = "Swipe up to share"
            arrowUp.isHidden = false
            arrowLeft.isHidden = true
        } else {
            swipeLabel.text = "Swipe left to share"
            arrowUp.isHidden = true
            arrowLeft.isHidden = false
        }
    }
}

