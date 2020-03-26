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
   
    // MARK: Enum
    
    enum GridLayoutView : Int {
        case none = -1 ,firstView = 0, secondView = 1, thirdView = 2
    }
    
    // MARK: Properties
    
    @IBOutlet weak var containerPhotoView: UIView!
    @IBOutlet var screenView: UIView!
    
    @IBOutlet weak var squarePhotoViewTopLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewTopRightButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomLeftButton: UIButton!
    @IBOutlet weak var squarePhotoViewBottomRightButton: UIButton!
    
    @IBOutlet var selectViewButton: [UIButton]!
    @IBOutlet var changePhotoViewButton: [UIButton]!
    
    @IBOutlet weak var arrowLeft: UIImageView!
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var swipeLabel: UILabel!
    
    private var currentButton = UIButton()
    private var currentGrid : GridLayoutView = .none
    private let pickerImage = UIImagePickerController()
    private let screenHeight = UIScreen.main.bounds.height
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        basicViewGridCollection()
        
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector (swipeScreen(_:)))
        swipeGestureUp.direction = .up
        screenView.addGestureRecognizer(swipeGestureUp)

        changeButtonImageName(for: currentButton)
        
        pickerImage.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
   // override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     //   super.viewWillTransition(to: size, with: coordinator)
        
        //let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector (swipeScreen(_:)))
        //let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeScreen(_:)))
        //swipeGestureUp.direction = .up
        //swipeGestureLeft.direction = .left
        
      //  if UIDevice.current.orientation.isLandscape
          //  screenView.gestureRecognizers?.removeAll()
            //screenView.addGestureRecognizer(swipeGestureLeft)
        //} else {
            //screenView.gestureRecognizers?.removeAll()
            //screenView.addGestureRecognizer(swipeGestureUp)
        //}
       // changeSwipeLabelAndArrow()
   // }
    
    // MARK: Manipulation methods
    
    @IBAction func selectViewButton(_ sender: UIButton) {
        selectGridCollection()
        selectButton(view: (CollageViewController.GridLayoutView(rawValue: sender.tag)!))
        currentGrid = GridLayoutView (rawValue: sender.tag) ?? .none
    }
    
    @IBAction func tapToChangePhotoButton(_ sender: UIButton) {
        currentButton = sender
        choosePhotoInLibrary ()
    }

    // MARK: Public methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            currentButton.imageView?.contentMode = .scaleAspectFill
            currentButton.setImage(imagePicked, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func swipeScreen (_ sender : UISwipeGestureRecognizer) {
        transformSwipeView(gesture: sender)
    }
    
    // MARK: Private methods
    
    private func alerteIfShareIsImpossible () {
        let alert = UIAlertController(title: "Empty Grid", message: "You can not share an empty grid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog ("The alert occured")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func basicViewGridCollection () {
       // Grid desired by default
        currentGrid = .secondView
        selectButton(view: .secondView)
        selectViewButton[0].imageView?.isHidden = true
        selectViewButton[1].imageView?.isHidden = false
        selectViewButton[2].imageView?.isHidden = true
    }
    
    private func changeButtonImageName (for button : UIButton) {
        // Used to compare images
         for photoButton in changePhotoViewButton {
              photoButton.setImage(UIImage(named: "Plus"), for: .normal)
          }
    }
    
    private func changeSwipeLabelAndArrow () {
        // Change text of swipe Label and arrow orientation
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
    
    private func checkCurrentGrid () {
        // Keep the grid selected by the user
        if currentGrid  == .secondView  {
            basicViewGridCollection()
        } else {
            currentGrid = GridLayoutView (rawValue: currentButton.tag) ?? .none
        }
    }
    
    private func checkIfGridPhotoIsComplete () -> Bool {
        // share if all photoViewButton have an image
        guard let image = UIImage(named: "Plus")?.pngData() else { return false }
            switch currentGrid {
            case .none :
                return false
            case .firstView:
                if  image != squarePhotoViewTopLeftButton.currentImage?.pngData() &&
                    image != squarePhotoViewBottomLeftButton.currentImage?.pngData() &&
                    image != squarePhotoViewBottomRightButton.currentImage?.pngData() {
                    return true
                }
            case .secondView:
                if  image != squarePhotoViewTopLeftButton.currentImage?.pngData() &&
                    image != squarePhotoViewTopRightButton.currentImage?.pngData() &&
                    image != squarePhotoViewBottomLeftButton.currentImage?.pngData() {
                    return true
                }
            case .thirdView:
                if  image != squarePhotoViewTopLeftButton.currentImage?.pngData() &&
                    image != squarePhotoViewTopRightButton.currentImage?.pngData() &&
                    image != squarePhotoViewBottomLeftButton.currentImage?.pngData() &&
                    image != squarePhotoViewBottomRightButton.currentImage?.pngData() {
                    return true
                }
            }
        alerteIfShareIsImpossible()
        return false
    }
    
    private func choosePhotoInLibrary () {
        pickerImage.allowsEditing = true
        pickerImage.sourceType = .photoLibrary
        pickerImage.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        present(pickerImage, animated: true, completion: nil)
    }
    
    private func imageToShare (view : UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: containerPhotoView.bounds)
        let image = renderer.image { context in
            containerPhotoView.drawHierarchy(in: containerPhotoView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    @ objc private func rotated () {
        // Taking into account the change of orientation
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector (swipeScreen(_:)))
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeScreen(_:)))
        swipeGestureUp.direction = .up
        swipeGestureLeft.direction = .left
        
        if UIDevice.current.orientation.isLandscape {
            screenView.gestureRecognizers?.removeAll()
            screenView.addGestureRecognizer(swipeGestureLeft)
            checkCurrentGrid()
        } else {
            screenView.gestureRecognizers?.removeAll()
            screenView.addGestureRecognizer(swipeGestureUp)
            checkCurrentGrid()
        }
        changeSwipeLabelAndArrow()
    }
    
    private func selectButton(view : GridLayoutView) {
        // Change Grid Layout View
        switch view {
        case .none :
            break
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
        // button is selected or not
        for button in selectViewButton {
            if button.isSelected == true {
                button.imageView?.isHidden = false
            } else {
                button.imageView?.isHidden = true
            }
        }
    }
    
    private func shareImage () {
        let contentToShare = imageToShare(view: containerPhotoView)
        let activityController = UIActivityViewController(activityItems: [contentToShare], applicationActivities: nil)
                    
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { (activityType, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.sharingFinished()
                return
                    } else {
                self.sharingFinished()
            }
        }
    }
    
    private func sharingFinished () {
        UIView.animate(withDuration: 0.5) {
            self.containerPhotoView.transform = .identity
        }
    }
    
    private func transformSwipeView ( gesture : UISwipeGestureRecognizer) {
        // animation to share grid
        let swipeUp = CGAffineTransform(translationX: 0, y: -screenHeight)
        let swipeLeft = CGAffineTransform(translationX: -screenHeight, y: 0)
        
        if checkIfGridPhotoIsComplete() == true {
            shareImage()
        }
        
        if UIDevice.current.orientation.isLandscape {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerPhotoView.transform = swipeUp
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerPhotoView.transform = swipeLeft
            }, completion: nil)
        }
        sharingFinished()
    }
    
}


