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

class CollageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        basicViewGridCollection()
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector (swipeScreen(_:)))
        swipeGestureUp.direction = .up
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeScreen(_:)))
        swipeGestureLeft.direction = .left
        
        screenView.addGestureRecognizer(swipeGestureUp)
        screenView.addGestureRecognizer(swipeGestureLeft)
        
        for button in changePhotoViewButton {
            button.setImage(UIImage(named: "Plus"), for: .normal)
            checkButtonName(yourButton: button)
        }
        
        
        image.delegate = self
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeSwipeLabelAndArrow()
        basicViewGridCollection()
    }
    
    func checkButtonName(yourButton: UIButton) {
       if yourButton.currentImage == UIImage(named: "Plus") {
          print("IMAGE NAME IS Plus")
       }
       else {
        print("IMAGE NAME IS NOT Image_Assigned")
       }
    }
    
    var currentButton = UIButton()
    let image = UIImagePickerController()
    let screenHeight = UIScreen.main.bounds.height

    @IBOutlet weak var containerPhotoView: UIView!
    @IBOutlet var screenView: UIView!
    @IBOutlet var selectViewbutton: [UIButton]!
    
    @IBOutlet weak var squarePhotoViewTopLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewTopRightButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomRightButton: UIButton!
    
    @IBOutlet var changePhotoViewButton: [UIButton]!
    
    @IBAction func tapToChangePhotoButton(_ sender: UIButton) {
     
        currentButton = sender
        choosePhotoInLibrary ()
        checkButtonName(yourButton: sender)
    }
    
    private func choosePhotoInLibrary () {
        
        
        image.allowsEditing = true
        image.sourceType = .photoLibrary
        image.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        present(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            currentButton.imageView?.contentMode = .scaleAspectFill
            currentButton.setImage(imagePicked, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func selectViewButton(_ sender: UIButton) {
        selectGridCollection()
        selectButton(view: (CollageViewController.GridLayoutView(rawValue: sender.tag)!))
        
    }
    
    enum GridLayoutView : Int {
        case firstView = 0, secondView = 1, thirdView = 2
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
        
        let swipeUp = CGAffineTransform(translationX: 0, y: -screenHeight)
        let swipeLeft = CGAffineTransform(translationX: -screenHeight, y: 0)

        if gesture.direction == .up && orientation.isPortrait == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerPhotoView.transform = swipeUp
            }, completion: nil)
            
        } else if gesture.direction == .left && orientation.isLandscape == true {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerPhotoView.transform = swipeLeft
            }, completion: nil)
        }
        
        if checkIfGirdPhotoIsComplete() == true {
        shareImage()
        } else {
            print ("Error you cannot share an empty grid")
            sharingFinished()
        }
    }
    
    
    private func shareImage () {
    
        let contentToShare = imageToShare(view: containerPhotoView)
                    
        let activityController = UIActivityViewController(activityItems: [contentToShare], applicationActivities: nil)
                    
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { (activityType, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print ("finish")
                self.sharingFinished()
                return
            } else {
                print("cancel")
                self.sharingFinished()
            }
        }
    }
    
    private func imageToShare (view : UIView) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(bounds: containerPhotoView.bounds)
        
        let image = renderer.image { context in
            containerPhotoView.drawHierarchy(in: containerPhotoView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    private func checkIfGirdPhotoIsComplete () -> Bool {
         
        let view = GridLayoutView (rawValue: currentButton.tag)
        
        switch view {
            
        case .firstView:
            
            if squarePhotoViewTopLeftButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewBottomLeftButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewBottomRightButton.currentImage != UIImage(named: "Plus") {
                return true
            }
            
        case .secondView:
            
            if squarePhotoViewTopLeftButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewTopRightButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewBottomLeftButton.currentImage != UIImage(named: "Plus") {
                return true
            }
            
        case .thirdView:
            
            return squarePhotoViewTopLeftButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewTopRightButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewBottomLeftButton.currentImage != UIImage(named: "Plus") &&
                squarePhotoViewBottomRightButton.currentImage != UIImage(named: "Plus")
            
        case .none:
            break
        }
        return false
    }
    
        
    private func sharingFinished () {
    
        UIView.animate(withDuration: 0.5) {
            self.containerPhotoView.transform = .identity
        }
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

