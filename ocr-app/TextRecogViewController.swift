//
//  TextRecogViewController.swift
//  ocr-app
//
//  Created by Maria Xina Rae Torres on 31/01/2019.
//  Copyright © 2019 Maria Xina Rae Torres. All rights reserved.
//
import UIKit
import FirebaseMLVision
import Firebase
class TextRecogViewController: UIViewController {
    var sourceImage: UIImage?
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var textV: UITextView!
    var textRecognizer: VisionTextRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageV.image = sourceImage
        self.textV.text = ""
        // Get an instance of VisionTextRecognizer
        let vision = Vision.vision()
        textRecognizer = vision.onDeviceTextRecognizer()
        runTextRecognition(image: self.imageV.image!)
    }
    
    func runTextRecognition(image: UIImage){
        // Initialize visionimage object passing the image to the constructor
        // Visionimage is an image or imagebuffer used in vision detection
        let visionImage = VisionImage(image: image)
        // Call process on the visiontextrecognizer which will then call a completion handler that has the optional visiontext and error objects
        textRecognizer.process(visionImage) { (visiontext, error) in
            self.processResult(from: visiontext, error: error)
        }
    }
    func processResult(from visiontext: VisionText?, error: Error?){
        guard let visionText = visiontext, let image = imageV.image else { return }
       self.textV.text = visionText.text
        print("WORD: \(visionText.blocks[0].lines[0].elements[1].text)")
    }
}
