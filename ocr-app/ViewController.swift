//
//  ViewController.swift
//  ocr-app
//
//  Created by Maria Xina Rae Torres on 28/01/2019.
//  Copyright © 2019 Maria Xina Rae Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageV: UIImageView!
    
    lazy var imagePicker: UIImagePickerController = {
        return UIImagePickerController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    //MARK: choose button action
    @IBAction func didTapChooseImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        // present view controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: image picker controller delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageV.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: segue action
    @IBAction func didTapTextRecog(_ sender: UIButton) {
        performSegue(withIdentifier: "textRecognition", sender: self)

    }
    
    //MARK: prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "textRecognition"{
            let vc = segue.destination as! TextRecogViewController
            vc.sourceImage = self.imageV.image
        }
    }
}

